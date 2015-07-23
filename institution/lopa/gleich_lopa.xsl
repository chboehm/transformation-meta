<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	
	
<!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	
<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>	


<!--Der Hauptknoten-->	
	<xsl:template match="lop">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


<xsl:template match="datensatz">	

<xsl:if test="objektart[text()='Neue Medien']">


		<xsl:variable name="id" select="id" />
		<xsl:element name="record">
			<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	
		
	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
		
			
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="id"></xsl:value-of>
					<xsl:text>lopa</xsl:text>
					</id>

	<!--recordCreationDate-->
	
				<recordCreationDate>
					<xsl:value-of select="current-dateTime()"/>
					</recordCreationDate>
			
				
					
	<!--recordChangeDate-->
				<recordChangeDate>
					<xsl:value-of select="current-dateTime()"/>
					</recordChangeDate>
	
	<!--recordType-->
				<recordType>
					<xsl:text>library</xsl:text>
					</recordType>
				
	
</xsl:element>




<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->


	
<xsl:element name="institution">
	
<!--institutionShortname-->			<institutionShortname>
							<xsl:text>Louise-Otto-Peters-Archiv</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Louise-Otto-Peters-Archiv</xsl:text>
							</institutionFull>
						
						<institutionID>lopa</institutionID>
						
<!--collection-->				<collection><xsl:text>Louise-Otto-Peters-Archiv</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-L324</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/louise-otto-peters-archiv/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>0</latitude>
							<longitude>0</longitude>
							</geoLocation>
			
</xsl:element>






<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
			
<!--Bibliothek__________________________Bibliothek___________________________Bibliothek-->

<xsl:if test="objektart[text()='Bibliothek']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->
	
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel"/>		
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="Verfasser"/>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
								</publishDate>
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<xsl:apply-templates select="Orte"/>
					
	<!--description-->
					<xsl:apply-templates select="Bemerkungen"/>
					
					<!--<xsl:if test="Bestand_x058x_">
						<description>
							<xsl:value-of select="Bestand_x058x_"/>
							<xsl:text> - Bezug: </xsl:text>
							<xsl:value-of select="Bezug_x058x_"/>
							</description>
					</xsl:if>-->
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Bib_Signatur"/>

		</xsl:element>
	</xsl:if>
	


<!--Akte___________Akte____________Akte-->


<xsl:if test="objektart[text()='Akte']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Akte</xsl:text></format>
	<!--documentType-->
	
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel"/>		
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="Verfasser"/>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

	<!--provenance Provinienz-->
					<xsl:apply-templates select="Provenienz"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
								</publishDate>
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<xsl:apply-templates select="Orte"/>
					
	<!--description-->
					
					<xsl:apply-templates select="Enthält"/>
					
					<xsl:if test="not(Enthält)">
					 	<xsl:apply-templates select="Bemerkungen"/>
						</xsl:if>
						
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur"/>

		</xsl:element>
	</xsl:if>



<!--Brief___________Brief____________Brief-->


<xsl:if test="objektart[text()='Brief']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Autograf</xsl:text></format>
	<!--documentType-->
					<documentType><xsl:text>Brief</xsl:text></documentType>
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel"/>		
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:if test="contains(Absender,'Verfass')">
						<author>
							<xsl:value-of select="normalize-space(substring-after(Absender,':'))"></xsl:value-of>
							</author>
						</xsl:if>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

	<!--provenance Provinienz-->
					<xsl:apply-templates select="Provenienz"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<xsl:choose>
								<xsl:when test="contains(Laufzeit-Datierung-Jahr,'.')">
									<publishDate>
										<xsl:value-of select="substring(translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), ''),5)" />
										</publishDate>		
									</xsl:when>
								<xsl:otherwise>
									<publishDate>
										<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
										</publishDate>
									</xsl:otherwise>
								</xsl:choose>
							
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					<xsl:apply-templates select="Sprache"/>
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<!--<xsl:apply-templates select="Orte"/>-->
					
	<!--description-->					
					<xsl:apply-templates select="Enthält"/>
					
					<xsl:if test="not(Enthält)">
					 	<xsl:apply-templates select="Bemerkungen"/>
						</xsl:if>
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur"/>

		</xsl:element>
	</xsl:if>





<!--Buch__________________________Buch___________________________Buch-->

<xsl:if test="objektart[text()='Buch']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->
	
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel"/>		
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="Verfasser"/>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
								</publishDate>
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<xsl:apply-templates select="Orte"/>
					
	<!--description-->
					<xsl:apply-templates select="Bemerkungen"/>
					
					<!--<xsl:if test="Bestand_x058x_">
						<description>
							<xsl:value-of select="Bestand_x058x_"/>
							<xsl:text> - Bezug: </xsl:text>
							<xsl:value-of select="Bezug_x058x_"/>
							</description>
					</xsl:if>-->
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur"/>

		</xsl:element>
	</xsl:if>
	









<!--Foto__________________________Foto___________________________Foto-->

<xsl:if test="objektart[text()='Foto']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Fotografie</xsl:text></format>
	<!--documentType-->
	
<!--TITLE-->

	<!--title Titelinformationen-->
					<!--<xsl:apply-templates select="Titel"/>	-->	
					<title><xsl:text>Fotografie - Louise-Otto-Peters-Archiv</xsl:text></title>
					<title_short><xsl:text>Fotografie - Louise-Otto-Peters-Archiv</xsl:text></title_short>
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="Verfasser"/>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
								</publishDate>
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<xsl:apply-templates select="Orte"/>
					
	<!--description-->
					<description>
					<xsl:for-each select="Titel">
						<xsl:value-of select="." />
						<xsl:text>&lt;br&gt;</xsl:text>
						</xsl:for-each>
						</description>
					<xsl:apply-templates select="Bemerkungen"/>
					
					<!--<xsl:if test="Bestand_x058x_">
						<description>
							<xsl:value-of select="Bestand_x058x_"/>
							<xsl:text> - Bezug: </xsl:text>
							<xsl:value-of select="Bezug_x058x_"/>
							</description>
					</xsl:if>-->
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur"/>

		</xsl:element>
	</xsl:if>
	




<!--Graphik__________________________Graphik___________________________Graphik-->

<xsl:if test="objektart[text()='Graphik']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Plakat</xsl:text></format>
	<!--documentType-->
					<documentType><xsl:text>Grafik</xsl:text></documentType>
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel"/>
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="Verfasser"/>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
								</publishDate>
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<xsl:apply-templates select="Orte"/>
					
	<!--description-->
					<description>
					<xsl:for-each select="Titel">
						<xsl:value-of select="." />
						<xsl:text>&lt;br&gt;</xsl:text>
						</xsl:for-each>
						</description>
					<xsl:apply-templates select="Bemerkungen"/>
					
					<!--<xsl:if test="Bestand_x058x_">
						<description>
							<xsl:value-of select="Bestand_x058x_"/>
							<xsl:text> - Bezug: </xsl:text>
							<xsl:value-of select="Bezug_x058x_"/>
							</description>
					</xsl:if>-->
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur"/>

		</xsl:element>
	</xsl:if>
	





<!--Neue Medien__________________________Neue Medien___________________________Neue Medien-->

<xsl:if test="objektart[text()='Neue Medien']">
	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format>
						<xsl:choose>
							<xsl:when test="contains(Titel,.'CD')">
								<xsl:text>Tonträger</xsl:text>
								</xsl:when>
							<xsl:when test="contains(Titel,.'DVD')">
								<xsl:text>Film</xsl:text>
								</xsl:when>
							</xsl:choose>
					<xsl:text>Plakat</xsl:text></format>
	<!--documentType-->
					<documentType><xsl:text>Grafik</xsl:text></documentType>
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel"/>
					<xsl:apply-templates select="Untertitel"/>		

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="Verfasser"/>
	
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Herausgeber"/>
					
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Reihe-Serie"/>

	<!--edtion Auflage-->
					<xsl:apply-templates select="Auflage"/>

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_-_ISSN"/>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="contains(Laufzeit-Datierung-Jahr,'-')">
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-before(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(substring-after(Laufzeit-Datierung-Jahr,'-'))"/>
								</publishDate>
							</xsl:when>
						<xsl:when test="not(Laufzeit-Datierung-Jahr)">
							
							</xsl:when>
						<xsl:otherwise>
							<displayPublishDate>
								<xsl:value-of  select="Laufzeit-Datierung-Jahr" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="translate(Laufzeit-Datierung-Jahr, translate(.,'0123456789-', ''), '')" />
								</publishDate>
							</xsl:otherwise>
						</xsl:choose>
					
	
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ersch__Ort"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag"/>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					
	<!--subjects-->
					<xsl:apply-templates select="Sachbegriffe-KS"/>
					<xsl:apply-templates select="Personen"/>
					<xsl:apply-templates select="Orte"/>
					
	<!--description-->
					<description>
					<xsl:for-each select="Titel">
						<xsl:value-of select="." />
						<xsl:text>&lt;br&gt;</xsl:text>
						</xsl:for-each>
						</description>
					<xsl:apply-templates select="Bemerkungen"/>
					
					<!--<xsl:if test="Bestand_x058x_">
						<description>
							<xsl:value-of select="Bestand_x058x_"/>
							<xsl:text> - Bezug: </xsl:text>
							<xsl:value-of select="Bezug_x058x_"/>
							</description>
					</xsl:if>-->
	
<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur"/>

		</xsl:element>
	</xsl:if>



		</xsl:element>
		</xsl:if>
	</xsl:template>
	
<!--Templates-->
	
	<xsl:template match="Sprache">
		<language>
			<xsl:value-of select="lower-case(normalize-space(.))" />
			</language>
		</xsl:template>
	
	<xsl:template match="Provenienz">
		<provenance>
			<xsl:value-of select="normalize-space(.)" />
			</provenance>
		</xsl:template>
	
	<xsl:template match="Auflage">
		<edition>
			<xsl:value-of select="normalize-space(.)" />
			</edition>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Bib_Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Enthält">
		<description>
			<xsl:if test="../Inhalt">
				<xsl:text>Inhalt: </xsl:text>
				<xsl:value-of select="../Inhalt" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Absender">
				<xsl:text>Absender: </xsl:text>
				<xsl:value-of select="../Absender" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Empfänger">
				<xsl:text>Empfänger: </xsl:text>
				<xsl:value-of select="../Empfänger" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Orte">
				<xsl:text> </xsl:text>
				<xsl:value-of select="../Orte" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Bemerkungen">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="../Bemerkungen" />
				</xsl:if>
			</description>
		</xsl:template>
	
	<xsl:template match="Bemerkungen">
		<description>
			<xsl:if test="../Inhalt">
				<xsl:text>Inhalt: </xsl:text>
				<xsl:value-of select="../Inhalt" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Absender">
				<xsl:text>Absender: </xsl:text>
				<xsl:value-of select="../Absender" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Empfänger">
				<xsl:text>Empfänger: </xsl:text>
				<xsl:value-of select="../Empfänger" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Orte">
				<xsl:text> </xsl:text>
				<xsl:value-of select="../Orte" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:if test="../Zugänglichkeit">
				<xsl:text>Zugänglichkeit: </xsl:text>
				<xsl:value-of select="../Zugänglichkeit" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="Sachbegriffe-KS">
		<xsl:for-each select="tokenize(.,';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Orte">
		<xsl:for-each select="tokenize(.,';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectGeographic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Personen">
		<xsl:for-each select="tokenize(.,';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)" />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<!--<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789-', ''), ''))" />
			</physical>
		</xsl:template>-->
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Ersch__Ort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Laufzeit-Datierung-Jahr">
		<displayPublishDate>
			<xsl:value-of select="normalize-space(.)" />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="substring-before(Bestand_x058x_,':')"/>
				</publishDate>
		</xsl:template>
	
	<xsl:template match="ISBN_-_ISSN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>
	
	<xsl:template match="Reihe-Serie">
		<series>
			<xsl:value-of select="normalize-space(.)" />
			</series>
		</xsl:template>
	
	<xsl:template match="Herausgeber">
		<xsl:for-each select="tokenize(.,';')">
			<editor>
				<xsl:value-of select="normalize-space(.)" />
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Verfasser">
		<xsl:for-each select="tokenize(.,';')">
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Titel">
			<title>
				<xsl:value-of select="."/>
				<xsl:if test="../Untertitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="../Untertitel" />
					</xsl:if>
				<xsl:if test="(../Absender) and not(contains(../Absender,'Verfasser'))">
					<xsl:text> - Von: </xsl:text>
					<xsl:value-of select="../Absender" />
					</xsl:if>
				<xsl:if test="../Empfänger">
					<xsl:text> - An: </xsl:text>
					<xsl:value-of select="../Empfänger" />
					</xsl:if>
				</title>
			
			<title_short>
					<xsl:value-of select="."/>
					</title_short>	
		</xsl:template>	
	
	<xsl:template match="Untertitel">
		<title_sub>
			<xsl:value-of select="."/>
			</title_sub>
		</xsl:template>
	
					
		
</xsl:stylesheet>