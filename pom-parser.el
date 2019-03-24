;;; pom.el --- Tools for using attributes from a Maven POM in JDE project files

;;;;
;;;;  This code is deprecated;
;;;;  please look at http://www.bitbucket.org/espenhw/jde-mvn/ instead.
;;;;

;;
;; Copyright (c) 2007 Espen Wiborg <espenhw@grumblesmurf.org>
;;
;; Permission to use, copy, modify, and distribute this software for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.
;;
;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
;; WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
;; AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
;; DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
;; PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
;; TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
;; PERFORMANCE OF THIS SOFTWARE.
;;
;; Revision control metadata:
;; $Id: pom-parser.el 58 2007-11-12 22:01:14Z espenhw $
;; $HeadURL: http://svn.grumblesmurf.org/svn/pom-el/trunk/pom-parser.el $
;;
;;;
;;
;; A typical prj.el now looks like this:
;;
;; (jde-project-file-version "1.0")
;; (jde-set-variables
;;  '(jde-compile-option-command-line-args
;;    (quote ("-Xlint:all" "-Xlint:-serial"))))
;;
;; (require 'pom-parser)
;; (with-pom ()
;;   (pom-set-jde-variables pom))
;;

(require 'cl)
(require 'jde)
(require 'xml)

(defgroup pom nil
  "Options controlling the Maven POM parser."
  :group 'tools)

(defcustom pom-file-name "pom.xml"
  "*Default name of a POM file."
  :type 'string
  :group 'pom)

(defcustom pom-default-compiler-source "1.3"
  "*Default value of the `source' parameter of
`maven-compiler-plugin'.  You shouldn't have to touch this unless
Maven's default changes."
  :type 'string
  :group 'pom)

(defcustom pom-default-compiler-target "1.1"
  "*Default value of the `target' parameter of
`maven-compiler-plugin'.  You shouldn't have to touch this unless
Maven's default changes."
  :type 'string
  :group 'pom)

(defcustom pom-maven-command "mvn"
  "*The command to execute Maven 2.  Set this to the full path to
`mvn' if that command is not on your path, or if it's called something
funky on your system."
  :type 'string
  :group 'pom)

(defvar *pom-cache*
  (make-hash-table :test 'equal)
  "The cache for parsed POM files.  Don't touch.")

(defvar *pom-node* nil
  "The default POM node operated on by most of the entrypoints.")

(defvar *mvn-output-buffer* (get-buffer-create " *POM parse output*")
  "The buffer that output from mvn is written to.")

(defun pom-clear-pom-cache ()
  "Clears the pom cache.  You may have to do this if you use parent
POMs, as the caching mechanism only takes the timestamp of the child
pom into account."
  (interactive)
  (clrhash *pom-cache*))

(defun* pom-find-pom-file (&optional (pom-file-name pom-file-name))
  "Find the next POM file upwards in the directory hierarchy."
  (interactive)
  (let ((pom (expand-file-name pom-file-name)))
    (while (not (file-exists-p pom))
      (if (jde-root-dir-p (file-name-directory pom))
          (error "%s not found" (file-name-nondirectory pom))
        (setq pom (expand-file-name (concat "../" (file-name-nondirectory pom))
                                    (file-name-directory pom)))))
    pom))

(defun pom-file-last-modified-time (file)
  "The last-modified time of `file', as a 32-bit integer."
  (let ((lastmod (nth 5 (file-attributes file))))
    (logior (lsh (nth 0 lastmod) 16)
            (nth 1 lastmod))))

(defun* pom-parse-pom (&optional (pom-file (pom-find-pom-file)))
  "Parses the effective POM for `pom-file', generated by calling `mvn
help:effective-pom', and caches the result until the POM is updated.
If `pom-file' is not specified, the result of `pom-find-pom-file' is
used.  The resulting XML node carries the compile classpath (as
determined by `mvn dependency:build-classpath') as the attribute
`pom:classpath' on the toplevel element."
  (let* ((pom-file-last-mod-time (pom-file-last-modified-time pom-file))
         (cached-pom-data (gethash pom-file *pom-cache*)))
    (if (and cached-pom-data
             (<= pom-file-last-mod-time (car cached-pom-data)))
        (cdr cached-pom-data)
      (message "Calling %s help:effective-pom dependency:build-classpath..."
               pom-maven-command)
      (let ((temp-pom (make-temp-file temporary-file-directory))
            (temp-cpfile (make-temp-file temporary-file-directory)))
        (with-current-buffer *mvn-output-buffer*
          (erase-buffer))
        (if (> (let ((default-directory (file-name-directory pom-file)))
                 (call-process pom-maven-command nil *mvn-output-buffer* t
                               "-B" "-N"
                               "-f" pom-file
                               "help:effective-pom"
                               "dependency:build-classpath"
                               (concat "-Doutput=" temp-pom)
                               "-DincludeScope=compile"
                               "-DincludeTypes=jar"
                               (concat "-Dmaven.dep.cpFile=" temp-cpfile)
                               "-Dmaven.dep.pathSeparator=:"))
               0)
            (progn (display-buffer *mvn-output-buffer* t)
                   (error "%s call failed" pom-maven-command))
          (let ((pom (pom-parse-pom-file temp-pom)))
            (if (null pom)
                (error "Failed to parse effective POM; the contents of %s might help diagnose" temp-pom)
              (let ((classpath (pom-parse-classpath-file temp-cpfile)))
                (push (cons 'pom:classpath classpath)
                      (xml-node-attributes pom)))
              (puthash pom-file (cons pom-file-last-mod-time pom)
                       *pom-cache*)
              (delete-file temp-pom)
              (delete-file temp-cpfile)
              pom)))))))

(defun pom-parse-classpath-file (classpath-file)
  (with-temp-buffer
    (insert "(\"")
    (insert-file-contents-literally classpath-file)
    (goto-char (point-max))
    (insert "\")")
    (goto-char (point-min))
    (replace-string ":" "\" \"")
    (read-from-whole-string (buffer-substring (point-min) (point-max)))))

(defun pom-parse-pom-file (pom-file)
  "Parses the file and returns the root node."
  (car (xml-parse-file pom-file)))

(defun pom-xml-first-child (node element)
  "Returns the first `element' child of `node'."
  (car (xml-get-children node element)))

(defun pom-xml-element-content (node)
  "Returns the (string) content of `node', recursively (much like the string() XPath function), or `nil' if there is no content."
  (if (null node)
      nil
    (mapconcat (lambda (e)
                 (if (stringp e) e ""))
               (xml-node-children node)
               "")))

(defun* pom-compile-classpath (&optional (pom-node *pom-node*))
  "The compile classpath of the project, as determined by
dependency:build-classpath with suitable options."
  (xml-get-attribute pom-node 'pom:classpath))

(defun* pom-get-property (property &optional (pom-node *pom-node*))
  "Resolves the Maven project property (e.g. `project.name')."
  (let ((elements (mapcar 'intern (split-string property "\\."))))
    (unless (eq (car elements) 'project)
      (error "Property '%s' must start with 'project'." property))
    (setq elements (cdr elements))
    (let ((node pom-node))
      (while elements
        (setq node (pom-xml-first-child node (pop elements))))
      (pom-xml-element-content node))))

(defun* pom-compiler-source (&optional (pom-node *pom-node*))
  "Returns the configured `source' option for javac, or
`pom-default-compiler-source' if not specified in the POM."
  (or (pom-plugin-configuration-property pom-node 'maven-compiler-plugin 'source)
      pom-default-compiler-source))

(defun* pom-compiler-target (&optional (pom-node *pom-node*))
  "Returns the configured `target' option for javac, or
`pom-default-compiler-target' if not specified in the POM."
  (or (pom-plugin-configuration-property pom-node 'maven-compiler-plugin 'target)
      pom-default-compiler-target))

(defvar *pom-default-plugin-group-id* 'org.apache.maven.plugins)

(defun* pom-plugin (pom-node
                    plugin-artifact-id
                    &optional (plugin-group-id *pom-default-plugin-group-id*)
                    (section 'build))
  "Returns the <plugin> element for the GROUP-ID:ARTIFACT-ID plugin in
SECTION."
  (let ((plugins (xml-get-children
                  (pom-xml-first-child (pom-xml-first-child pom-node section)
                                       'plugins)
                  'plugin)))
    (find (cons plugin-group-id plugin-artifact-id)
          plugins
          :test (function equal)
          :key (lambda (node)
                 (let ((group-id (pom-xml-element-content
                                  (pom-xml-first-child node 'groupId)))
                       (artifact-id (pom-xml-element-content
                                     (pom-xml-first-child node 'artifactId))))
                 (cons (or (and group-id (intern group-id))
                           *pom-default-plugin-group-id*)
                       (intern artifact-id)))))))

(defun* pom-plugin-configuration-property
  (pom-node plugin-artifact-id property
            &optional (plugin-group-id 'org.apache.maven.plugins)
            (section 'build))
  "Returns the configured value of PROPERTY (a symbol) for the
GROUP-ID:PLUGIN-ARTIFACT-ID plugin in SECTION, that is the value of
the <PROPERTY> element in the <configuration> element in that plugin."
  (let ((plugin-configuration
         (pom-xml-first-child (pom-plugin pom-node plugin-artifact-id
                                          plugin-group-id section)
                              'configuration)))
    (pom-xml-element-content (pom-xml-first-child plugin-configuration
                                                  property))))

(defun* pom-set-jde-variables (&optional (pom-node *pom-node*))
  "Sets the JDE variables `jde-project-name', `jde-global-classpath',
`jde-compile-option-directory', `jde-compile-option-source',
`jde-compile-option-target', `jde-compile-option-encoding',
`jde-sourcepath' and `jde-built-class-path' to sensible values based
on the given POM."
  (let ((target-directory (pom-get-property "project.build.outputDirectory" pom-node)))
    (jde-set-variables
     '(jde-project-name (pom-get-property "project.name" pom-node))
     '(jde-global-classpath (list* target-directory
                                   (pom-compile-classpath pom-node)))
     '(jde-compile-option-directory target-directory)
     '(jde-compile-option-source (list (pom-compiler-source pom-node)))
     '(jde-compile-option-target (list (pom-compiler-target pom-node)))
     '(jde-compile-option-encoding (pom-plugin-configuration-property pom-node 'maven-compiler-plugin 'encoding))
     '(jde-sourcepath (pom-get-property "project.build.sourceDirectory" pom-node))
     '(jde-built-class-path (list target-directory)))))

(defmacro with-pom (pom-file &rest body)
  "Execute BODY with `*pom-node*' bound to the result of calling `pom-parse-pom' on POM-FILE."
  `(let ((*pom-node* (pom-parse-pom (or ,pom-file (pom-find-pom-file)))))
     ,@body))

(put 'with-pom 'lisp-indent-function 1)

(provide 'pom-parser)
