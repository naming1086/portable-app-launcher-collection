${SegmentFile}

${SegmentPrePrimary}
    CreateDirectory $DataDirectory\Library\Preferences\AndroidStudio4.0\options

    ${IfNot} ${FileExists}  $DataDirectory\Library\Preferences\AndroidStudio4.0\options\jdk.table.xml
        FileOpen    $0  $DataDirectory\Library\Preferences\AndroidStudio4.0\options\jdk.table.xml w
        FileWrite   $0  `\
                <application>$\r$\n  \
                  <component name="ProjectJdkTable">$\r$\n    \
                    <jdk version="2">$\r$\n      \
                      <name value="" />$\r$\n      \
                      <type value="Android SDK" />$\r$\n      \
                      <homePath value="" />$\r$\n      \
                      <roots />$\r$\n    \
                    </jdk>$\r$\n  \
                  </component>$\r$\n\
                </application>`
        FileClose $0

        CreateDirectory $DataDirectory\Library\Android\sdk
        ReadEnvStr $0 PAL:DataDir:ForwardSlash
        ${XMLWriteAttrib}   $DataDirectory\Library\Preferences\AndroidStudio4.0\options\jdk.table.xml \
                '/application/component[@name="ProjectJdkTable"]/jdk[@version="2"][child::name[@value]][child::type[@value="Android SDK"]][child::roots]/homePath' \
                value   \
                "$0/Library/Android/sdk"
    ${EndIf}

    ${IfNot} ${FileExists}  $DataDirectory\Library\Preferences\AndroidStudio4.0\options\ide.general.xml
        FileOpen    $0  $DataDirectory\Library\Preferences\AndroidStudio4.0\options\ide.general.xml w
        FileWrite   $0  `\
                <application>  \
                  <component name="GeneralSettings">    \
                    <option name="defaultProjectDirectory" value="" />  \
                  </component>\
                </application>`
        FileClose $0

        ReadEnvStr $0 PortableApps.comDocuments
        ${XMLWriteAttrib}   $DataDirectory\Library\Preferences\AndroidStudio4.0\options\ide.general.xml \
                '/application/component[@name="GeneralSettings"]/option[@name="defaultProjectDirectory"]' \
                value   \
                $0\AndroidStudioProjects
    ${EndIf}
!macroend

${SegmentPostPrimary}
    Rename  $DataDirectory\Library\Caches\AndroidStudio4.0\log  \
            $DataDirectory\Library\Logs\AndroidStudio4.0
!macroend
