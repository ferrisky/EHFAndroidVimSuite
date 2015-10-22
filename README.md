# EHFAndroidVimSuite

### Process to create gtags in Android
<!-- goto android root-->
	cd \<ANDROID_ROOT>
	
<!-- generate source file list -->
	$ find . \( ! -path "./out*" -a ! -name ".git*" \) -a \( -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.aidl" -o -name "*.java" -o -name "*.S" \) > somefile
	
<!-- gtag it -->
	~$ gtags -f somefile

### Bookmark Usage

After installation you can directly start using it. You can do this by either using the default shortcuts or the commands:

| Action                                          | Shortcut    | Command                      |
|-------------------------------------------------|-------------|------------------------------|
| Add/remove bookmark at current line             | `mm`        | `:BookmarkToggle`            |
| Add/edit/remove annotation at current line      | `mi`        | `:BookmarkAnnotate <TEXT>`   |
| Jump to next bookmark in buffer                 | `mn`        | `:BookmarkNext`              |
| Jump to previous bookmark in buffer             | `mp`        | `:BookmarkPrev`              |
| Show all bookmarks (toggle)                     | `ma`        | `:BookmarkShowAll`           |
| Clear bookmarks in current buffer only          | `mc`        | `:BookmarkClear`             |
| Clear bookmarks in all buffers                  | `mx`        | `:BookmarkClearAll`          |
| Move up bookmark at current line                | `mkk`       | `:BookmarkMoveUp`            |
| Move down bookmark at current line              | `mjj`       | `:BookmarkMoveDown`          |
| Save all bookmarks to a file                    |             | `:BookmarkSave <FILE_PATH>`  |
| Load bookmarks from a file                      |             | `:BookmarkLoad <FILE_PATH>`  |

--
Edgar, Howard and Ferry's Android VIM Suite 
