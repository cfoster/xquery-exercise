<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                exclude-result-prefixes="fn">

  <xsl:template match="/clip">
    
    <clip>
      <pid>
        <xsl:value-of select="@pid" />
      </pid>
      <partner>
        <xsl:value-of select="partner/link/@pid" />
      </partner>
      <updated_time>
        <xsl:value-of select="fn:current-dateTime()"/>
        <xsl:comment>No updated time in Appendix A, so using
                     fn:current-dateTime() for completeness</xsl:comment>
      </updated_time>

      <xsl:copy-of select="title" />

      <synopses>
        <xsl:apply-templates select="synopses/synopsis" />
      </synopses>

      <media_type>
        <xsl:choose>
          <xsl:when test="media_type/@value eq 'audio_video'">
            Video
          </xsl:when>
          <xsl:otherwise>
            None-Video --- I guess. (Just 1 example in Appendix A)
          </xsl:otherwise>
        </xsl:choose>
      </media_type>
    </clip>
  </xsl:template>

  <xsl:template match="synopsis">
    <xsl:element name="{@length}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
