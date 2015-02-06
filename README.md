# EHFAndroidVimSuite
cd <ANDROID_ROOT>
$~ find . \( ! -name "./out*" -a ! -name ".git*" \) -a \( -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.aidl" -o -name "*.java" -o -name "*.S" \) > somefile
$~ gtags -f somefile

Edgar, Howard and Ferry's Android VIM Suite 
