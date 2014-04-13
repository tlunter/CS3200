<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
            </head>
            <body>
                <ol>
                    <xsl:for-each select="sites/site">
                        <li>
                            <xsl:value-of select="@name"/>
                            <xsl:text> at </xsl:text>
                            <xsl:value-of select="@latitude"/>
                            <xsl:text>° N </xsl:text>
                            <xsl:value-of select="@longitude"/>
                            <xsl:text>° W</xsl:text>
                            <ul>
                                <xsl:for-each select="tower">
                                    <li>
                                        <xsl:value-of select="@name"/>
                                        <xsl:text> Height: </xsl:text>
                                        <xsl:value-of select="@height"/>
                                        <xsl:text> Sides: </xsl:text>
                                        <xsl:value-of select="@sides"/>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </li>
                    </xsl:for-each>
                </ol>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>