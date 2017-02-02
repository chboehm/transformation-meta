<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	xmlns:zs="http://www.loc.gov/zing/srw"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	
	
<!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	
<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>	

<!--Der Hauptknoten-->	
	<xsl:template match="genderbibHH">
		<xsl:element name="catalog">
			<xsl:apply-templates select="zs:record" />
		</xsl:element>
	</xsl:template>



<!--Der Objektknoten-->
	<xsl:template match="zs:record">	
		
		<!-- <xsl:if test="datafield[6]"> -->
		
		<!--<xsl:if test="not(datafield[@tag='078'])">-->
		<!--<xsl:if test="datafield[@tag='078'][1][text()='Bildtonträger']">-->
		<!--<xsl:if test="(datafield[@tag='078'][text()='Monographie']) or (datafield[@tag='078'][text()='Reihe']) or (datafield[@tag='078'][text()='Anthologie']) or (datafield[@tag='078'][text()='Reihenband']) or (datafield[@tag='078'][text()='Mehrbändiges Werk']) or (datafield[@tag='078'][text()='Zeitschrift']) or (datafield[@tag='078'][text()='Artikel'])">-->
		<!--<xsl:if test="datafield[@tag='078'][text()='Artikel']">-->
		<!--<xsl:if test="(datafield[@tag='078'][text()='Monographie']) 
		or (datafield[@tag='078'][text()='Anthologie']) 
		or (datafield[@tag='078'][text()='Reihenband'])
		or (datafield[@tag='078'][text()='Mehrbändiges Werk'])">-->
			
			<xsl:variable name="id" select="controlfield[@tag='001']" />	
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	
			
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
			
					
			<!-- <xsl:variable name="rel" select="datafield[@tag='QUE']/subfield[@code='L']" />
			<xsl:variable name="mbd" select="datafield[@tag='GTO']/subfield[@code='L']" /> -->

<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
		<id><xsl:value-of select="$id" /><xsl:text>genderwissen</xsl:text></id>
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
		<recordType><xsl:text>library</xsl:text></recordType>
				
</xsl:element>


<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->


<xsl:element name="institution">
	
	<institutionShortname><xsl:text>Zentrum GenderWissen</xsl:text></institutionShortname>
	<institutionFull><xsl:text>Zentrum GenderWissen - Zentrale Bibliothek Frauenforschung und Gender Studies Hamburg</xsl:text></institutionFull>
	<institutionID><xsl:text>genderwissen</xsl:text></institutionID>
	<collection><xsl:text>genderwissen</xsl:text></collection>
	<!--isil-->	
	<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/zentrum-genderwissen-hamburg/</xsl:text></link>
	<geoLocation>
			<latitude>53.5699100</latitude>
			<longitude>9.9765800</longitude>
	</geoLocation>
			
</xsl:element>	


<!--Monographie________________Monographie___________________________Monographie-->
<!--Monographie________________Monographie___________________________Monographie-->
<!--Monographie________________Monographie___________________________Monographie-->

<!-- <xsl:if test="(datafield[@tag='078'][1][text()='Monographie']) 
		or (datafield[@tag='078'][1][text()='MOnographie']) 
		or (datafield[@tag='078'][1][text()='Aufsatzsammlung']) 
		or (datafield[@tag='078'][1][text()='Anthologie']) 
		or (datafield[@tag='078'][1][text()='Reihe'])
		or (datafield[@tag='078'][1][text()='Mehrbändiges Werk'])
		or (not(datafield[@tag='078']))"> -->
		
	<xsl:element name="dataset">

		<xsl:variable name="GT1" select="datafield[@tag='GT1']/subfield[@code='L']" />
		
<!--FORMAT-->

	<!--typeOfRessource-->
		<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>		

	<!--format Objektartinformationen-->
	<!--documentType-->
	<xsl:choose>
		<xsl:when test="(not(datafield[@tag='078'])) 
		and (//document[@idn=$GT1]/datafield[@tag='078']='Zeitschrift')">
			<format><xsl:text>Periodika</xsl:text></format>
			<searchfilter><xsl:text>Zeitschriftenheft</xsl:text></searchfilter>
			</xsl:when>
		<xsl:when test="datafield[@tag='078'][1][text()='Reihe']">
			<format><xsl:text>Periodika</xsl:text></format>
			<searchfilter><xsl:text>Reihe</xsl:text></searchfilter>
			</xsl:when>
		<xsl:otherwise>
			<format><xsl:text>Buch</xsl:text></format>
			<xsl:choose>
				<xsl:when test="datafield[@tag='078'][1][text()='Monographie']">
					<searchfilter><xsl:text>Monografie</xsl:text></searchfilter>
						</xsl:when>
					<xsl:otherwise>
						<searchfilter><xsl:text>Sammelband</xsl:text></searchfilter>
						</xsl:otherwise>
					</xsl:choose>
				<xsl:for-each select="datafield[@tag='078']">
					<documentType><xsl:value-of select="." /></documentType>
					</xsl:for-each>
				</xsl:otherwise>
		</xsl:choose>
	
<!--TITLE-->	

	<!--title Titelinformationen-->	
			<xsl:choose>
				<xsl:when test="datafield[@tag='331']">
					<xsl:apply-templates select="datafield[@tag='331']" />
					</xsl:when>
				<xsl:otherwise>
					<title>
						<xsl:text>[Ohne Titelangabe]</xsl:text>
						</title>
					<title_short>
						<xsl:text>[Ohne Titelangabe]</xsl:text>
						</title_short>
					</xsl:otherwise>
				</xsl:choose>
			

	<!--alternativeTitle-->
			<xsl:apply-templates select="datafield[@tag='370']" />
			
	<!--originalTitle-->
			<xsl:apply-templates select="datafield[@tag='341']" />

<!--RESPONSIBLE-->	
		
	<!--author Autorinneninformation-->
			<xsl:apply-templates select="datafield[@tag='100']" />
			<xsl:apply-templates select="datafield[@tag='104']" />
			<xsl:apply-templates select="datafield[@tag='108']" />

	<!--editor Herausgeberinneninformationen-->
			<xsl:if test="(not(datafield[@tag='100'])) and
					(not(datafield[@tag='104'])) and 
					(not(datafield[@tag='108']))">
				<xsl:apply-templates select="datafield[@tag='359']" />
				</xsl:if>
	
	<!--entity Körperschaft-->
			<xsl:apply-templates select="datafield[@tag='200']" />
			
	<!--series-->
			<xsl:choose>
				<xsl:when test="datafield[@tag='GT1']">
					<xsl:apply-templates select="datafield[@tag='GT1']" />
					</xsl:when>
				<xsl:when test="datafield[@tag='GTU']">
					<xsl:apply-templates select="datafield[@tag='GTU']" />
					</xsl:when>
				<xsl:when test="datafield[@tag='GT0']">
					<xsl:apply-templates select="datafield[@tag='GT0']" />
					</xsl:when>
				</xsl:choose>

	<!--edition-->
			<xsl:apply-templates select="datafield[@tag='403']" />

<!--IDENTIFIER-->
		
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="datafield[@tag='540']" />
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="datafield[@tag='542']" />
	
<!--PUBLISHING-->
		
	<!--display / publishDate Jahresangabe-->
			<!--<xsl:apply-templates select="datafield[@tag='425']" />-->
		
		<xsl:choose>
			<xsl:when test="datafield[@tag='425'][@ind1='a']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
					</publishDate>
				</xsl:when>
			<xsl:when test="datafield[@tag='425'][@ind1='b']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']"/>
					</publishDate>
				</xsl:when>
			<xsl:when test="datafield[@tag='425'][@ind1='c']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					</publishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</publishDate>	
					
					<!--<timeSpan>
						<timeSpanStart><xsl:value-of select="datafield[@tag='425'][@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select="datafield[@tag='425'][@ind1='c']" /></timeSpanEnd>
					</timeSpan>-->
					</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425']"/>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
		<!--
		<xsl:if test="datafield[@tag='425'][@ind1='a']">
			<displayPublishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</displayPublishDate>
			<publishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</publishDate>
			</xsl:if>
		
		<xsl:if test="datafield[@tag='425'][@ind1='a']">
			<displayPublishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</displayPublishDate>
			<publishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</publishDate>
			</xsl:if>
		
		<xsl:if test="datafield[@tag='425']">
			<xsl:choose>
				<xsl:when test="datafield[@tag='078'][1][text()='Reihe']">
					<timeSpan>
						<timeSpanStart><xsl:value-of select="datafield[@tag='425'][@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select="datafield[@tag='425'][@ind1='c']" /></timeSpanEnd>
					</timeSpan>
					</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="datafield[@tag='425'][@ind1='a']" />	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>-->
						
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="datafield[@tag='594']" />
			<xsl:apply-templates select="datafield[@tag='410']" />
			
	<!--publisher Verlag-->
			<xsl:apply-templates select="datafield[@tag='412']" />

<!--PHYSICAL INFORMATION-->
		
	<!--physical Seitenangabe-->
			<xsl:apply-templates select="datafield[@tag='433']" />
			
	<!--dimensions-->
			<xsl:apply-templates select="datafield[@tag='435']" />
			
	<!--specificMaterialDesignation-->
			<xsl:apply-templates select="datafield[@tag='434']" />
			<xsl:apply-templates select="datafield[@tag='437']" />

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
			<xsl:apply-templates select="datafield[@tag='037']" />

	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="datafield[@tag='THS']" />
			<xsl:apply-templates select="datafield[@tag='710']" />
			<xsl:apply-templates select="datafield[@tag='740']" />
			<xsl:apply-templates select="datafield[@tag='902']" />

	<!--description-->
			<xsl:apply-templates select="datafield[@tag='750']" />

	<!--listOfContents-->
			<xsl:apply-templates select="datafield[@tag='753']" />		
			<xsl:apply-templates select="datafield[@tag='530']" />
	
<!--OTHER-->
				
	<!--shelfMark Signatur-->
			<xsl:apply-templates select="datafield[@tag='544']" />

	</xsl:element>










<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
			
			
		</xsl:element>
		<!-- </xsl:if> -->
	</xsl:template>

	<xsl:template match="datafield[@tag='427']">
		<collectionHolding>
			<xsl:value-of select="." />
			</collectionHolding>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='653']">
		<dimension>
			<xsl:value-of select="subfield[@code='a']" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="subfield[@code='c']" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="subfield[@code='d']" />
			</dimension>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='359']">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsg.')">
				<editor>
					<xsl:value-of select="normalize-space(substring-after(.,'Hrsg.:'))" />
					</editor>
				</xsl:when>
			<xsl:otherwise>
				<editor>
					<xsl:value-of select="normalize-space(.)" />
					</editor>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='QUE']/subfield[@code='b']">
		<xsl:variable name="physical" select="substring-after(.,';')" />
		<xsl:choose>
			<xsl:when test="not(contains(.,';'))">
				<physical>
					<xsl:value-of select="normalize-space(substring-after(., 'S.'))" />
					</physical>
				</xsl:when>
			<xsl:when test="not(contains($physical,'S.'))">
				<physical>
					<xsl:value-of select="normalize-space(substring-after(substring-before(.,';'), 'S.'))"></xsl:value-of>
					</physical>
				</xsl:when>
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(substring-after(., 'S.'))" />
					</physical>
				</xsl:otherwise>
			</xsl:choose>
		<!--<original>
			<xsl:value-of select="."></xsl:value-of>
		</original>
		<test>
			<xsl:value-of select="$physical"></xsl:value-of>
		</test>
		<physical>
			<xsl:value-of select="normalize-space(substring-after(., 'S.'))" />
			</physical>-->
		</xsl:template>
	
	<xsl:template match="datafield[@tag='200']">
		<entity>
			<xsl:value-of select="subfield[@code='a']" />
			</entity>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='544']">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='GTU']">
		<series>
			<xsl:value-of select="." />
			</series>
		</xsl:template>	

	<xsl:template match="datafield[@tag='GT1']">
		<series>
			<xsl:value-of select="subfield[@code='a']" />
			</series>
		<xsl:if test="subfield[@code='b']">
			<seriesNr>
				<xsl:value-of select="subfield[@code='b']" />
				</seriesNr>
			</xsl:if>
		</xsl:template>		
	
	<xsl:template match="datafield[@tag='GT0']">
		<series>
			<xsl:value-of select="subfield[@code='a']" />
			</series>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='403']">
		<edition>
			<xsl:value-of select="." />
			</edition>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='542']">
		<issn>
			<xsl:value-of select="." />
			</issn>
		</xsl:template>

	<xsl:template match="datafield[@tag='540']">
		<xsl:for-each select=".">
			<isbn>
				<xsl:value-of select="subfield[@code='a']" />
				</isbn>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='753']">
		<listOfContents>
			<xsl:value-of  select="." />
			</listOfContents>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='530']">
		<listOfContents>
			<xsl:value-of  select="." />
			</listOfContents>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='750']">
		<description>
			<xsl:value-of  select="." />
			</description>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='THS']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="subfield[@code='a']" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='710']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="subfield[@code='a']" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='740']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='902']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="subfield[@code='a']" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='037']">
		<xsl:for-each select=".">
			<language_code>
				<xsl:value-of select="." />
				</language_code>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='434']">
		<specificMaterialDesignation>
			<xsl:value-of select="." />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='437']">
		<specificMaterialDesignation>
			<xsl:value-of select="." />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='435']">
		<dimension>
			<xsl:value-of select="." />
			</dimension>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='433']">
		<physical>
			<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
			</physical>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='410']">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='412']">
		<publisher>
			<xsl:value-of select="." />
			</publisher>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='594']">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='425']">
		
		<xsl:choose>
			<xsl:when test=".[@ind1='a']">
				<displayPublishDate>
					<xsl:value-of select=".[@ind1='a']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(.[@ind1='a'], translate(.,'0123456789', ''), '')"/>
					</publishDate>
				</xsl:when>
			<xsl:when test=".[@ind1='b']">
				<displayPublishDate>
					<xsl:value-of select=".[@ind1='b']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(.[@ind1='b'], translate(.,'0123456789', ''), '')"/>
					<!--<xsl:value-of select=".[@ind1='b']"/>-->
					</publishDate>
				</xsl:when>
			<xsl:when test="datafield[@tag='425'][@ind1='c']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(.[@ind1='b'], translate(.,'0123456789', ''), '')"/>
					<!--<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />-->
					</publishDate>
				<publishDate>
					<xsl:value-of select="translate(.[@ind1='c'], translate(.,'0123456789', ''), '')"/>
					<!--<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />-->
					</publishDate>	
					
					<!--<timeSpan>
						<timeSpanStart><xsl:value-of select=".[@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select=".[@ind1='c']" /></timeSpanEnd>
					</timeSpan>-->
					</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="."/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="."/>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
	
		<!--<xsl:choose>
			<xsl:when test="../datafield[@tag='078'][1][text()='Reihe']">
				<timeSpan>
					<timeSpanStart><xsl:value-of select="@ind1='b'" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select="translate(subfield[@code='c'], translate(.,'0123456789', ''), '')" /></timeSpanEnd>
				</timeSpan>	
				</xsl:when>
			<xsl:when test="../datafield[@tag='078'][1][text()='Zeitschrift']">
				<timeSpan>
					<timeSpanStart><xsl:value-of select=".[@ind1='b']" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select=".[@ind1='c']" /></timeSpanEnd>
				</timeSpan>	
				</xsl:when>
			<xsl:when test="../datafield[@tag='078'][1][text()='ÖEZA-Zeitschrift']">
				<timeSpan>
					<timeSpanStart><xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" /></timeSpanStart>
					<timeSpanEnd></timeSpanEnd>
				</timeSpan>	
				</xsl:when>
			</xsl:choose>-->
		
		</xsl:template>
	
	<xsl:template match="datafield[@tag='108']">
		<xsl:choose>
			<xsl:when test="contains(subfield[@code='b'],'Hrsg.')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'Übers.')">
				<contributor>
					<xsl:value-of select="subfield[@code='a']" />
				</contributor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'[Regie]')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="subfield[@code='a']" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>

	<xsl:template match="datafield[@tag='104']">
		<xsl:choose>
			<xsl:when test="contains(subfield[@code='b'],'Hrsg.')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'Übers.')">
				<contributor>
					<xsl:value-of select="subfield[@code='a']" />
				</contributor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'[Regie]')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="subfield[@code='a']" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='100']">
		<xsl:choose>
			<xsl:when test="contains(subfield[@code='b'],'Hrsg.')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'Übers.')">
				<contributor>
					<xsl:value-of select="subfield[@code='a']" />
				</contributor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'[Regie]')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="subfield[@code='a']" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='341']">
		<originalTitle>
			<!--<xsl:value-of select="." />-->
			<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			
			</originalTitle>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='370']">
		<alternativeTitle>
			<!--<xsl:value-of select="." />-->
			
			<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			
			</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='331']">
		
		<title>
			<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			
				<!--<xsl:value-of select="translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ¬', '1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ')" />-->
				<!--<xsl:value-of select="datafield[@tag='331']" />-->
			
			<xsl:if test="../datafield[@tag='335']">
					<xsl:text>: </xsl:text>
					<xsl:value-of select="../datafield[@tag='335']"></xsl:value-of>
				</xsl:if>
				
			</title>
			
			<title_short>
				<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
				
				
				<!--<xsl:value-of select="translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ¬', '1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ')" />-->
			</title_short>
		
		<xsl:if test="../datafield[@tag='335']">
			<title_sub>
				<xsl:value-of select="../datafield[@tag='335']" />
				</title_sub>
			</xsl:if>

		</xsl:template>


</xsl:stylesheet>
