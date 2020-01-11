
### On Emacs 

January 10th, 2020

Over the last 20 years I've used many  environments for programming and editing files (vim, Emacs, Eclipse, NetBeans, PHPStorm, Visual Studio, just to name some). While I will use the right tool for the right job, I'm partial to Emacs.


**Emacs is easy to extend** - You can modify Emacs while it's running, within Emacs. There is no need for a separate development environment. You write some elisp and then evaluate the expressions within Emacs. There is no need to set up a project for plugin development, and no need to learn a custom language with lots of syntax. I'm not a fan of vimscript, powershell, or scala for this reason, but I digress.

**Emacs allows you to optimize your workflow** - I dislike having to switch between multiple applications, it's a waste of time. As Emacs is easy to extend, you can optimize your workflow so everything is a few keystrokes away. For projects, I manage my todo-list, program, run shell commands, and do technical writing all within Emacs. I even have grammar checking in Emacs thanks to integrating language tool.

**Emacs allows you to program using keyboard macros** - Keyboard macros allows you save keystrokes/executed commands and run them later. This allows you to be really hacky and get things done quickly. Need a one-off program to save the current file, then execute a shell command? Write a macro. Need a one-off program to move the current line to a different buffer? Use a macro. Any one-off action you find repetitive and it's not worth writing elisp for, try writing a macro instead. The real ah-ha moment for me is when I realized you can run any function that's not bound to an active key, such as with *M-x function-name*. Keep in mind other people don't use Emacs, so for project-related repetitive operations, they should be within a build script of some sort.

Of course, there are downsides to using Emacs.

**Learning Emacs takes time** - The way I think about Emacs is it's a programming environment for itself. Key bindings are merely shortcuts to invoking  elisp functions. When you write elisp, you will have to spend time learning it's core API. Emacs introspection helps though.

**Configuring Emacs takes time** - You have to invest time to tweak Emacs the way you want it, and it's never perfect. You have to remind yourself to invest your time wisely to achieve your goals. Sometimes it's better not to modify Emacs so you can finish your real work.

**Emacs is insecure** - Emacs allows the use of revoked certificates.  Additionally it's common to download packages from melpa/github to configure Emacs how you want it. As these packages are executed within Emacs, this can easily lead to malware being installed on your computer. Even worse, you essentially can't trust that what you see on the screen is actually is not is tampered with. For this reason, I review elisp which I use in my setups. Additionally, I sandbox Emacs in such a way where it would be hard for malware to exfiltrate data. 

It would be great if there was a straight forward method to  access multiple compartmentalized Emacs instances from a trusted Emacs instance. This would be useful to restrict what compromised Emacs instances can access.

Update on 2020-01-11: Reddit user https://www.reddit.com/user/skeeto/ clarified Emacs was updated in 2016 to reject certificates which don't match the targeted host name being connected to. Emacs 26.3 still allows revoked certificates to be used.
