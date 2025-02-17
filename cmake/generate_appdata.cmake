# add release notes to the appdata file
file(READ "${CHANGELOG_HTML}" HTML_CHANGELOGS)
# it is not allowed to have multiple texts without being in an environment
# So the description will be used for it
string(REGEX REPLACE "<p>([^<]*)<\\/p>" "\\1" RELEASES ${HTML_CHANGELOGS}) # remove paragraph environment
string(REGEX REPLACE "<h4>([A-Za-z0-9]*)<\\/h4>" "<p>\\1</p>" RELEASES ${RELEASES}) # h4 is unknow to appdata so change it to a paragraph environment
string(REPLACE "\n" "\n\t" RELEASES ${RELEASES}) # add tabulator
string(REGEX REPLACE "<h3>(v[1-9]\\.[0-9]\\.[0-9]) - ([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])<\\/h3>" "<release version='\\1' date='\\2'>\n\t<description>" RELEASES ${RELEASES})
string(REGEX REPLACE "<hr \\/>" "</description>\n\t</release>" RELEASES ${RELEASES})
configure_file(${APPDATA_CONF} ${APPDATA})
