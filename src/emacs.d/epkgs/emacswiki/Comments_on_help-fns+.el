Add your comment below, at the end.

[new]
Hi, it after installing from melpa help-fns+ I got the warning that interactive-p is an obsolete function that one should use called-interactively-p instead. Do you mind if code? -- PuercoPop 2013-11-17 18:44 UTC


----

You can ignore all such compiler warnings.  The byte-compiler assumes that the code being compiled is written only for the same Emacs version as the byte-compiler. For many third-party libraries the code is designed to work with multiple Emacs versions. And that is the case here.
-- DrewAdams 2013-11-17 19:16 UTC


----

[new]

Hi, It seems to break the <code>?</code>/<code>RET</code> key function (<code>package-menu-describe-package</code>) in <code>M-x list-packages</code>. -- JunkBlocker 2014-05-02 05:23 UTC


----

Should be OK now - please download and try the latest.  (Emacs Dev changed the development code recently to use a defstruct for the package description.) -- DrewAdams 2014-05-02 15:12 UTC


----

Thank you, DrewAdams, it is working correctly now.
-- Anonymous 2014-05-03 03:42 UTC

----

You're welcome.  Thanks for the bug report. -- DrewAdams


[new]

----

Hi, I installed hep-fns+ with el-get, but I can't find the functions with M-x I have to explicitly add (require 'help-fns+) in my init file. Is this an issue with el-get or help-fns+? 
Thank you!
Here's my setting in the init file for el-get if it helps.
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
(with-current-buffer
(url-retrieve-synchronously
"https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
(goto-char (point-max))
(eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

-- Anonymous 2014-10-09 17:42 UTC


----

I replied to your posting of the same question [[http://stackoverflow.com/a/26290889/729907 here]].

I'm no expert on el-get; sorry. Perhaps someone else can help with that. I would say just put <tt>[[help-fns+.el]]</tt> in your `load-path' and `require' it - done. - DrewAdams

-- DrewAdams 2014-10-10 02:57 UTC


----

Hello Drew. Are commands `describe-buffer' and `describe-keymap' missing autoload cookie on purpose?
I'm also starting a new emacs init based on el-get and this seems to be the root of the problem that person above me encountered.

-- myeffort 2014-11-05 04:09 UTC


----

Yes.  Autoload cookies need to be at top-level, and it is not necessarily the case that loading the file will define those functions - they are not defined for some versions of Emacs.

The simplest approach, IMO, is to just `require' a library.  But you can also add `autoload' statements to your init file. For example:

    (autoload 'describe-buffer "help-fns+" "Describe an existing buffer." t)

-- DrewAdams 2014-11-05 19:14 UTC


----

There seems to be a bug that affects describe-package. The version check includes (> emacs-minor-version 24), but there is no emacs 24.24 yet. Because of this, the second describe-package gets evaluated for me (on emacs 24.4) but it doesn't work. Evaluating the first definition instead works fine.

-- Anonymous 2015-03-03 16:31 UTC


----

The most recent change switches to auto-do-load, for which I get a void function error in Emacs 24.4 (Aquamacs 3.2). I suspect it should be "autoload-do-load", but I'm not sure (and if I should check on a straight Emacs 24.4 build, I can do that).

-- Anonymous 2015-08-31 04:11 UTC


----

@Anonymous: Typo fixed to `autoload-do-load'.  Thanks!

-- DrewAdams 2015-08-31 05:05 UTC


----

I found a bug with the latest version of this file that causes the following error:

{{{
Lisp error: (wrong-type-argument sequencep t)
}}}

This patch should fix it:

{{{
--- help-fns+.el.orig	2015-09-09 13:56:17.000000000 -0600
+++ help-fns+.el	2015-09-09 14:00:27.000000000 -0600
@@ -1979,7 +1979,7 @@
                      (safe-var  (get variable 'safe-local-variable))
                      (vardoc    (help-documentation-property variable 'variable-documentation
                                                              nil 'ADD-HELP-BUTTONS))
-                     (vardoc    (and vardoc  (not (string= "" vardoc))))
+                     (vardoc    (and (not (string= "" vardoc)) vardoc))
                      (doc       (or vardoc  (help-documentation-property alias 'variable-documentation
                                                                          nil 'ADD-HELP-BUTTONS)))
                      (extra-line  nil))
@@ -2240,7 +2240,7 @@
                      (safe-var  (get variable 'safe-local-variable))
                      (vardoc    (help-documentation-property variable 'variable-documentation
                                                              nil 'ADD-HELP-BUTTONS))
-                     (vardoc    (and vardoc  (not (string= "" vardoc))))
+                     (vardoc    (and (not (string= "" vardoc)) vardoc))
                      (doc       (or vardoc  (help-documentation-property alias 'variable-documentation
                                                                          nil 'ADD-HELP-BUTTONS)))
                      (extra-line  nil))
}}}

-- jguenther 2015-09-09 20:02 UTC


----

@jguenther: Right; thanks.  I had already noticed the same thing and fixed it this morning.  Try the latest version here on the wiki.  (That should be mirrored to MELPA within a day.)  [P.S. It needs to be `equal', not `string=' in the fix, since VARDOC might not be a string.]

-- DrewAdams 2015-09-09 22:57 UTC

