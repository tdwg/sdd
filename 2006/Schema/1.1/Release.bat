REM Prepare SDD Release from SVN release branch
REM Force release number
SET REL=SDD1.1beta11-rc1
REM 
ECHO OFF
REM
REM update ReleaseNotes.txt from template
SET PATHSAVE=%PATH%
SET PATH=%PATH%;"C:\Program Files\TortoiseSVN\bin";
SET RelNotesTemplate=ReleaseNotesTemplate.txt
SET RelNotes=ReleaseNotes.txt
REM Clear read-only bit on RelNotes
attrib -r %RelNotes%
SubWCRev.exe . %RelNotesTemplate% %RelNotes%
REM Set read-only to try to force people to edit the template, not the constructed file
attrib +r %RelNotes% 
REM zip for release everything except zip file itself if it exists

SET PATH=%PATH%;C:\cygwin\bin
zip  %REL%.zip * -x %REL%.zip

REM Try to make %RelNotes% read only so that people work in the template

SET PATH=%PATHSAVE%
