(gptel-make-tool
 :name "open_file"
 :function (lambda (file)
             (find-file-noselect file))
 :description "Open the specified file using 'find-file-noselect' so it is available for other operations. If the file needs to be read the 'read_buffer' function can be used next."
 :args (list '(:name "file"
                     :type string
                     :description "The path to the file to open."))
 :category "gptel-examples")

(gptel-make-tool
 :name "search_project"
 :function (lambda (text)
             (progn
               (projectile-ripgrep text)
               (let ((results (get-buffer "*rg*")))
                 (kill-buffer "*rg*")
                 results)))
 :description "Search for text in the project files with 'projectile-ripgrep'."
 :args (list '(:name "text"
                     :type string
                     :description "Text to search for in project files."))
 :category "searching")

(gptel-make-tool
 :name "switch_project"
 :function (lambda (project)
             (projectile-switch-project-by-name project))
 :description "Switch to a specified project."
 :args (list '(:name "project"
                     :type string
                     :description "The name of the project to switch to."))
 :category "project")

(gptel-make-tool
 :name "list_projects"
 :function (lambda ()
             projectile-known-projects)
 :description "Retrieve a list of known projects from 'projectile-known-projects'."
 :category "project")

(gptel-make-tool
 :name "switch_project"
 :function (lambda (project)
             (projectile-switch-project-by-name project))
 :description "Switch to a specified project."
 :args (list '(:name "project"
                     :type string
                     :description "The name of the project to switch to."))
 :category "project")

(gptel-make-tool
 :name "read_buffer"
 :function (lambda (buffer-name)
             (if (get-buffer buffer-name)
                 (with-current-buffer buffer-name
                   (buffer-string))
               (error "Buffer not found")))
 :description "Read content from a specified buffer with 'get-buffer'"
 :args (list '(:name "buffer-name"
                     :type string
                     :description "Name of the buffer to read from."
                     ))
 :category "buffer")

(gptel-make-tool
 :name "create_file"
 :function (lambda (path filename content)
             (let ((full-path (expand-file-name filename path)))
               (with-temp-buffer
                 (insert content)
                 (write-file full-path))
               (format "Created file %s in %s" filename path)))
 :description "Create a new file with the specified content"
 :args (list '(:name "path"
										 :type string
										 :description "The directory where to create the file")
             '(:name "filename"
										 :type string
										 :description "The name of the file to create")
             '(:name "content"
										 :type string
										 :description "The content to write to the file"))
 :category "filesystem")

(gptel-make-tool
 :name "get_current_buffer_name"
 :function (lambda ()
             (buffer-name))
 :description "Return the name of the current buffer."
 :args nil
 :category "gptel-tools")

(gptel-make-tool
 :name "insert_text"
 :function (lambda (text)
             (insert text))
 :description "Insert specified text into the current buffer."
 :args (list '(:name "text"
										 :type string
										 :description "Text to insert into the buffer."
										 ))
 :category "buffer")

(gptel-make-tool
 :name "arbitrary_elisp"
 :function (lambda (expression)
             (eval-expression 'expression))
 :description "Execute an elisp expression passed in as a string."
 :args (list '(:name "expression"
										 :type string
										 :description "elisp expression to execute.  For instance '(point-min)'"
										 ))
 :category "function")

(gptel-make-tool
 :name "current_directory_path"
 :function (lambda ()
             default-directory)
 :description "Retrieve the file path for the current directory."
 :args nil
 :category "file-system")

(gptel-make-tool
 :name "list_directory"
 :function (lambda (directory)
             (let ((files (directory-files directory)))
               (mapconcat 'identity files "\n")))
 :description "List files in the specified directory."
 :args (list '(:name "directory"
                     :type string
                     :description "The path of the directory to list."))
 :category "file-system")

(gptel-make-tool
 :name "navigate_file_system"
 :function (lambda (direction)
             (if (string= direction "up")
                 (cd "..")
               (cd (read-directory-name "Enter directory to navigate down:"))))
 :description "Navigate up or down the file system."
 :args (list '(:name "direction"
                     :type string
                     :description "Specify 'up' to go up one directory or provide a directory name to navigate down."))
 :category "file-system")

(gptel-make-tool
 :name "get_project_root"
 :function (lambda ()
             (projectile-project-root))
 :description "Get the current project root."
 :args nil
 :category "project")
