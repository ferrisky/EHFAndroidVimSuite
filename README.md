# EHFAndroidVimSuite

### Process to create gtags in Android
<!-- goto android root-->
	cd \<ANDROID_ROOT>
	
<!-- generate source file list -->
	$ find . \( ! -name "./out*" -a ! -name ".git*" \) -a \( -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.aidl" -o -name "*.java" -o -name "*.S" \) > somefile
	
<!-- gtag it -->
	~$ gtags -f somefile

--
Edgar, Howard and Ferry's Android VIM Suite 
