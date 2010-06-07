# Addons to work with MediaWiki wikis.

# Create a folder "mediawiki_extensions" in the projects directory that
# will contain a series of symlinks for my extensions, so when I create a
# new wiki, I can just symlink the extensions directory to this one
function mw_extensions {
    projects
    mkdir mediawiki_extensions
    cd mediawiki_extensions
    ln -s $WKPROJECTS/mediawiki-peerreview PeerReview
    ln -s $WKPROJECTS/mediawiki-embedvideo EmbedVideo
    ln -s $WKPROJECTS/mediawiki-bookdesigner BookDesigner
}

# Right after we run the web-based installer, do the setup that we need. Move
# the LocalSettings.php file where it needs to be, symlink to the extensions
# folder, and add the include statements to LocalSettings.php
function mw_setup {
    mv config/LocalSettings.php .
    rm -rf extensions
    ln -s $WKPROJECTS/mediawiki_extensions extensions

    echo 'include_once("$IP/extensions/PeerReview/PeerReview.php");' >> LocalSettings.php
    echo 'include_once("$IP/extensions/EmbedVideo/EmbedVideo.php");' >> LocalSettings.php
    echo 'include_once("$IP/extensions/BookDesigner/BookDesigner.php");' >> LocalSettings.php
}

