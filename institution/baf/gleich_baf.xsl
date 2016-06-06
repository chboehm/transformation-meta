<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="baf">
		<xsl:element name="catalog">
			<xsl:apply-templates select="//Bestand[1]" />
			<xsl:apply-templates select="//Reihe_1[1]" />
			<xsl:apply-templates select="//Titel_Hauptband[1]" />
			<xsl:apply-templates select="object" />
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>



<!--Tektonik aus Bestand aus Aktentiteln-->
<!--Tektonik aus Bestand aus Aktentiteln-->
<!--Tektonik aus Bestand aus Aktentiteln-->


<xsl:template match="//Bestand">

	<xsl:for-each select="../Aktentitel">
	
	<xsl:element name="record">
	

<!--vufind_______________________________vufind_______________________________vufind-->		
		
	<xsl:element name="vufind">
		
		<id>
			<xsl:value-of select="translate(../Bestand, '.&quot; +()/:-äüö,', '')" />
			<xsl:text>baf</xsl:text></id>
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
		<recordType><xsl:text>systematics</xsl:text></recordType>
		
		</xsl:element>

<!--institution_______________________________institution_______________________________institution-->
	
	<xsl:element name="institution">
		
		<institutionShortname><xsl:text>BAF</xsl:text></institutionShortname>
		<institutionFull><xsl:text>BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs</xsl:text></institutionFull>
		<institutionID><xsl:text>baf</xsl:text></institutionID>
		<collection><xsl:text>baf</xsl:text></collection>
		<isil><xsl:text>Tü 133</xsl:text></isil>
		<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/baf/</xsl:text></link>
		<geoLocation>
			<latitude>48.5232420</latitude>
			<longitude>9.0527320</longitude>
			</geoLocation>
			
		</xsl:element>
		
<!--dataset_______________________________dataset_______________________________dataset-->

	<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
			<!--<format><xsl:text>Periodika</xsl:text></format>-->
	<!--searchfilter-->
			<!--<searchfilter><xsl:text>Zeitschriftenheft</xsl:text></searchfilter>-->

<!--TITLE-->
	
	<!--title Titelinformationen-->
	
			<title><xsl:value-of select="../Bestand"/></title>
			<title_short><xsl:value-of select="../Bestand"/></title_short>
			
		</xsl:element>
			
		<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="translate(../Bestand, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Bestand" /></hierarchy_top_title>
					
					<is_hierarchy_id>
						<xsl:value-of select="translate(../Bestand, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:value-of select="../Bestand" />
						</is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="../Bestand"></xsl:value-of>
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		
		</xsl:element>


<!--Tektonik aus Klassifikation aus Aktentiteln-->
<!--Tektonik aus Klassifikation aus Aktentiteln-->
<!--Tektonik aus Klassifikation aus Aktentiteln-->

<xsl:element name="record">
	

<!--vufind_______________________________vufind_______________________________vufind-->		
		
	<xsl:element name="vufind">
		
		<id>
			<xsl:value-of select="translate(../Klassifikation, '.&quot; +()/:-äüö,', '')" />
			<xsl:text>baf</xsl:text></id>
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
		<recordType><xsl:text>systematics</xsl:text></recordType>
		
		</xsl:element>

<!--institution_______________________________institution_______________________________institution-->
	
	<xsl:element name="institution">
		
		<institutionShortname><xsl:text>BAF</xsl:text></institutionShortname>
		<institutionFull><xsl:text>BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs</xsl:text></institutionFull>
		<institutionID><xsl:text>baf</xsl:text></institutionID>
		<collection><xsl:text>baf</xsl:text></collection>
		<isil><xsl:text>Tü 133</xsl:text></isil>
		<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/baf/</xsl:text></link>
		<geoLocation>
			<latitude>48.5232420</latitude>
			<longitude>9.0527320</longitude>
			</geoLocation>
			
		</xsl:element>
		
<!--dataset_______________________________dataset_______________________________dataset-->

	<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
			<!--<format><xsl:text>Periodika</xsl:text></format>-->
	<!--searchfilter-->
			<!--<searchfilter><xsl:text>Zeitschriftenheft</xsl:text></searchfilter>-->

<!--TITLE-->
	
	<!--title Titelinformationen-->
	
			<title><xsl:value-of select="../Klassifikation"/></title>
			<title_short><xsl:value-of select="../Klassifikation"/></title_short>
			
		</xsl:element>
			
		<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="translate(../Bestand, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Bestand" /></hierarchy_top_title>
					
					<hierarchy_parent_id>
						<xsl:value-of select="translate(../Bestand, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="../Bestand" /></hierarchy_parent_title>
					
					<is_hierarchy_id>
						<xsl:value-of select="translate(../Klassifikation, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:value-of select="../Klassifikation" />
						</is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="../Klassifikation"></xsl:value-of>
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		
		</xsl:element>
		
		</xsl:for-each>
	</xsl:template>




<!--Zeitschriftenheft aus Artikel-->
<!--Zeitschriftenheft aus Artikel-->
<!--Zeitschriftenheft aus Artikel-->

<xsl:template match="//Reihe_1">

	<xsl:for-each select="../Erscheinungsform[text()='Aufsatz']">
	
	<xsl:if test="../Reihe_1[string-length() != 0]">
	
	<xsl:element name="record">
	

<!--vufind_______________________________vufind_______________________________vufind-->		
		
	<xsl:element name="vufind">
		
		<id>
			<xsl:value-of select="translate(../Reihe_1, '.&quot; +()/:-äüö,', '')" />
			<xsl:value-of select="translate(../ISSN, '.&quot; +()/:-äüö,', '')" />
			<xsl:value-of select="translate(../Heftnummer, '.&quot; +()/:-äüö,', '')" />
			<xsl:text>baf</xsl:text></id>
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
		<recordType><xsl:text>library</xsl:text></recordType>
		
		</xsl:element>

<!--institution_______________________________institution_______________________________institution-->
	
	<xsl:element name="institution">
		
		<institutionShortname><xsl:text>BAF</xsl:text></institutionShortname>
		<institutionFull><xsl:text>BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs</xsl:text></institutionFull>
		<institutionID><xsl:text>baf</xsl:text></institutionID>
		<collection><xsl:text>baf</xsl:text></collection>
		<isil><xsl:text>Tü 133</xsl:text></isil>
		<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/baf/</xsl:text></link>
		<geoLocation>
			<latitude>48.5232420</latitude>
			<longitude>9.0527320</longitude>
			</geoLocation>
			
		</xsl:element>
		
<!--dataset_______________________________dataset_______________________________dataset-->

	<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
			<format><xsl:text>Periodika</xsl:text></format>
	<!--searchfilter-->
			<searchfilter><xsl:text>Zeitschriftenheft</xsl:text></searchfilter>

<!--TITLE-->
	
	<!--title Titelinformationen-->
	
			<title>
				<xsl:choose>
					<xsl:when test="../Hefttitel[string-length() != 0]">
						<xsl:value-of select="../Hefttitel"/>
							<xsl:if test="contains(../Heftnummer,'.')">
								<xsl:text> (</xsl:text>
								<xsl:value-of select="normalize-space(substring-after(../Heftnummer,'.'))" />
								<xsl:text>)</xsl:text>
								</xsl:if>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../Reihe_1"/>
						</xsl:otherwise>
					</xsl:choose>
				</title>
				
			<title_short>
				<xsl:choose>
					<xsl:when test="../Hefttitel[string-length() != 0]">
						<xsl:value-of select="../Hefttitel"/>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../Reihe_1"/>
						</xsl:otherwise>
					</xsl:choose>
				</title_short>

<!--IDENTIFIER-->
	
	<!--isbn-->
			<xsl:apply-templates select="../ISSN[1][string-length() != 0]"/>
			
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
			<xsl:apply-templates select="../Jahr[string-length() != 0]"/>
				
	
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="../Verlag[string-length() != 0]"/>
			<xsl:apply-templates select="../Erscheinungsort[string-length() != 0]"/>
			
		</xsl:element>
			
		<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="translate(../Reihe_1, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(../ISSN, '.&quot; +()/:-äüö,', '')" />
						<!--<xsl:value-of select="translate(../Heftnummer, '.&quot; +()/:-äüö,', '')" />-->
						<xsl:text>baf</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Reihe_1" /></hierarchy_top_title>
					
				<xsl:if test="../Hefttitel[string-length() != 0]">
					<hierarchy_parent_id>
						<xsl:value-of select="translate(../Reihe_1, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(../ISSN, '.&quot; +()/:-äüö,', '')" />
						<!--<xsl:value-of select="translate(../Heftnummer, '.&quot; +()/:-äüö,', '')" />-->
						<xsl:text>baf</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="../Reihe_1" /></hierarchy_parent_title>
					</xsl:if>
					
					<is_hierarchy_id>
						<xsl:value-of select="translate(../Reihe_1, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(../ISSN, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(../Heftnummer, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:choose>
							<xsl:when test="../Hefttitel[string-length() != 0]">
								<xsl:value-of select="../Hefttitel"/>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../Reihe_1"/>
								</xsl:otherwise>
							</xsl:choose>
						</is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="../Heftnummer"></xsl:value-of>
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		
		</xsl:element>
		
		</xsl:if>
		
		</xsl:for-each>
	</xsl:template>


<!--Sammelband aus Artikel-->
<!--Sammelband aus Artikel-->
<!--Sammelband aus Artikel-->

<xsl:template match="//Titel_Hauptband">

	<xsl:for-each select="../Erscheinungsform[text()='Aufsatz']">
	
	<xsl:if test="../Titel_Hauptband[string-length() != 0]">
	
	<xsl:element name="record">
	

<!--vufind_______________________________vufind_______________________________vufind-->		
		
	<xsl:element name="vufind">
		
		<id>
			<xsl:value-of select="translate(../Titel_Hauptband, '.&quot; +()/:-äüö,', '')" />
			<xsl:value-of select="translate(../ISBN, '.&quot; +()/:-äüö,', '')" />
			<xsl:text>baf</xsl:text></id>
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
		<recordType><xsl:text>library</xsl:text></recordType>
		
		</xsl:element>

<!--institution_______________________________institution_______________________________institution-->
	
	<xsl:element name="institution">
		
		<institutionShortname><xsl:text>BAF</xsl:text></institutionShortname>
		<institutionFull><xsl:text>BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs</xsl:text></institutionFull>
		<institutionID><xsl:text>baf</xsl:text></institutionID>
		<collection><xsl:text>baf</xsl:text></collection>
		<isil><xsl:text>Tü 133</xsl:text></isil>
		<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/baf/</xsl:text></link>
		<geoLocation>
			<latitude>48.5232420</latitude>
			<longitude>9.0527320</longitude>
			</geoLocation>
			
		</xsl:element>
		
<!--dataset_______________________________dataset_______________________________dataset-->

	<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
			<format><xsl:text>Buch</xsl:text></format>
	<!--searchfilter-->
			<searchfilter><xsl:text>Sammelband</xsl:text></searchfilter>

<!--TITLE-->
	
	<!--title Titelinformationen-->
	
			<title>
				<xsl:value-of select="../Titel_Hauptband"/>
				</title>
				
			<title_short>
				<xsl:value-of select="../Titel_Hauptband"/>
				</title_short>

<!--IDENTIFIER-->
	
	<!--isbn-->
			<xsl:apply-templates select="../ISSN[1][string-length() != 0]"/>
			<xsl:apply-templates select="../ISBN[1][string-length() != 0]"/>
			
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
			<xsl:apply-templates select="../Jahr[string-length() != 0]"/>
				
	
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="../Verlag[string-length() != 0]"/>
			<xsl:apply-templates select="../Erscheinungsort[string-length() != 0]"/>
			
		</xsl:element>
			
		<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="translate(../Titel_Hauptband, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(../ISBN, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Titel_Hauptband" /></hierarchy_top_title>
					
					<!--<hierarchy_parent_id>
						<xsl:value-of select="translate(../Titel_Hauptband, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(../ISBN, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="../Titel_Hauptband" /></hierarchy_parent_title>-->
					
					<is_hierarchy_id>
						<xsl:value-of select="translate(../Titel_Hauptband, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:value-of select="../Titel_Hauptband" />
						</is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="../Titel_Hauptband" />
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		
		</xsl:element>
		
		</xsl:if>
		
		</xsl:for-each>
	</xsl:template>



<!--Der Objektknoten-->
	<xsl:template match="object">
		
						
		<!--<xsl:variable name="id" select="MEDNR[1]"/>-->
		
		<xsl:variable name="id">
			
		<xsl:choose>
			<xsl:when test="Erscheinungsform[text()='Zeitschrift']">
				<xsl:value-of select="translate(Titel[1], '.&quot; +()/:-äüö,', '')" />
				<!--<xsl:value-of select="substring(translate(Titel[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />-->
				<xsl:value-of select="translate(ISSN, '.&quot; +()/:-äüö,', '')" />
				<!--<xsl:value-of select="translate(Heftnummer, '.&quot; +()/:-äüö,', '')" />-->
				</xsl:when>	
			<xsl:otherwise>
				<xsl:value-of select="substring(translate(Titel[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
				<xsl:value-of select="substring(translate(Aktentitel[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
				<xsl:value-of select="substring(translate(AutorInnen[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
				<xsl:value-of select="substring(translate(Signatur[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
				<xsl:value-of select="substring(translate(Zaehlung[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
				<xsl:value-of select="translate(ISBN, translate(.,'0123456789', ''), '')" />	
				</xsl:otherwise>	
			</xsl:choose>
			
			</xsl:variable>
		
		
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>baf</xsl:text>
					</xsl:attribute>

				
<!--vufind_______________________________vufind_______________________________vufind-->		
		
	<xsl:element name="vufind">
		
		<id><xsl:value-of select="$id"/><xsl:text>baf</xsl:text></id>
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
		<xsl:choose>
			<xsl:when test="Aktentitel">
				<recordType><xsl:text>archive</xsl:text></recordType>
				</xsl:when>
			<xsl:otherwise>
				<recordType><xsl:text>library</xsl:text></recordType>
				</xsl:otherwise>
			</xsl:choose>
				
		</xsl:element>

<!--institution_______________________________institution_______________________________institution-->
	
	<xsl:element name="institution">
		
		<institutionShortname><xsl:text>BAF</xsl:text></institutionShortname>
		<institutionFull><xsl:text>BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs</xsl:text></institutionFull>
		<institutionID><xsl:text>baf</xsl:text></institutionID>
		<collection><xsl:text>baf</xsl:text></collection>
		<isil><xsl:text>Tü 133</xsl:text></isil>
		<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/baf/</xsl:text></link>
		<geoLocation>
			<latitude>48.5232420</latitude>
			<longitude>9.0527320</longitude>
			</geoLocation>
			
		</xsl:element>






<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
			
<!--Buch__________________________Monographie___________________________Sammelband-->



<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<xsl:choose>
					<xsl:when test="Aktentitel">
						<format><xsl:text>Archivgut</xsl:text></format>	
						<searchfilter><xsl:text>Akte</xsl:text></searchfilter>	
						</xsl:when>
					<xsl:when test="Erscheinungsform[text()='Aufsatz']">
						<format><xsl:text>Artikel</xsl:text></format>	
						<searchfilter><xsl:text>Artikel</xsl:text></searchfilter>	
						</xsl:when>
					<xsl:when test="Erscheinungsform[text()='Zeitschrift']">
						<format><xsl:text>Periodika</xsl:text></format>	
						<searchfilter><xsl:text>Zeitschrift</xsl:text></searchfilter>	
						</xsl:when>
					<xsl:otherwise>
						<format><xsl:text>Buch</xsl:text></format>	
						
						<xsl:choose>
							<xsl:when test="HerausgeberInnen[string-length() != 0]">
								<searchfilter><xsl:text>Sammelband</xsl:text></searchfilter>	
								</xsl:when>
							<xsl:otherwise>
								<searchfilter><xsl:text>Monografie</xsl:text></searchfilter>	
								</xsl:otherwise>
							</xsl:choose>
						
						</xsl:otherwise>
					</xsl:choose>
	
	<!--documentType-->		
				<!--<xsl:if test="Erscheinungsform[string-length() != 0]">
					<documentType>
						<xsl:value-of select="Erscheinungsform"></xsl:value-of>
						</documentType>
					</xsl:if>		-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel[1][string-length() != 0]"/>	
				<xsl:apply-templates select="Originaltitel[1][string-length() != 0]"/>	
				<xsl:apply-templates select="Aktentitel[1][string-length() != 0]"/>	
				<!--<xsl:apply-templates select="Untertitel[string-length() != 0]"/>	-->
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorInnen[string-length() != 0]"/>	

	<!--editor-->
				<xsl:apply-templates select="HerausgeberInnen[string-length() != 0]"/>
	
	<!--series-->
				<xsl:apply-templates select="GT1[1][string-length() != 0]"/>

<!--IDENTIFIER-->
	
	<!--isbn-->
				<xsl:apply-templates select="ISBN[1][string-length() != 0]"/>
				<xsl:apply-templates select="ISSN[1][string-length() != 0]"/>
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr[string-length() != 0]"/>
				<xsl:apply-templates select="Laufzeit[string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
				<xsl:apply-templates select="Erscheinungsort[string-length() != 0]"/>
				
	<!--sourceInfo-->
				<xsl:apply-templates select="Erscheinungsform[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->
	
	<!--physical-->
				<xsl:apply-templates select="Umf_Ill_Beil[string-length() != 0]"/>
				<xsl:apply-templates select="Umfang[string-length() != 0]"/>
				<xsl:apply-templates select="Seite_von_bis[string-length() != 0]"/>
	
<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
				<xsl:apply-templates select="Suchwoerter[string-length() != 0]"/>
				<xsl:apply-templates select="Personenregister[string-length() != 0]"/>
				<xsl:apply-templates select="BAWOrt_Landkreis_Land[string-length() != 0]"/>
				
	<!--description-->	
				<xsl:apply-templates select="Enthaelt[string-length() != 0]"/>
				<xsl:apply-templates select="Darin[string-length() != 0]"/>
	
	<!--collectionHolding-->
				
				<xsl:if test="Bestand[string-length() != 0]">
					<sourceInfo>
						<xsl:value-of select="normalize-space(Bestand)" />
						</sourceInfo>
					</xsl:if>
				<!--<xsl:apply-templates select="Bestand[string-length() != 0]"/>-->
				
				<xsl:if test="Erscheinungsform[text()='Zeitschrift']">
					<collectionHolding>
						<xsl:value-of select="Zaehlung" />
						<xsl:if test="Heftnummer[string-length() != 0]">
							<xsl:text> </xsl:text>
							<xsl:value-of select="substring-before(substring-after(Heftnummer,'[L='),']')"></xsl:value-of>
							</xsl:if>
						</collectionHolding>
					</xsl:if>
		
	<!--issue-->
				<xsl:apply-templates select="Heftnummer[1][string-length() != 0]"/>
	
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Standort[1][string-length() != 0]"/>
				<xsl:apply-templates select="Signatur[1][string-length() != 0]"/>
			
		
		</xsl:element>	


<xsl:if test="Aktentitel">
<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="translate(Bestand, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Bestand" /></hierarchy_top_title>
					
					<hierarchy_parent_id>
						<xsl:value-of select="translate(Klassifikation, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:value-of select="Klassifikation" />
						</hierarchy_parent_title>
					
					<is_hierarchy_id>
						<xsl:value-of select="$id"/><xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Aktentitel" /></is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="Aktentitel"></xsl:value-of>
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		</xsl:if>	

<xsl:if test="Erscheinungsform[text()='Zeitschrift']">
<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="$id"/><xsl:text>baf</xsl:text>
						</hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Titel" /></hierarchy_top_title>
				
					<is_hierarchy_id>
						<xsl:value-of select="$id"/><xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Titel" /></is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="Titel"></xsl:value-of>
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		</xsl:if>	

<xsl:if test="Erscheinungsform[text()='Aufsatz']">

<xsl:element name="functions">
			
			<hierarchyFields>
				
					<hierarchy_top_id>
						<xsl:value-of select="translate(Titel_Hauptband, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(ISBN, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(Reihe_1, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(ISSN, '.&quot; +()/:-äüö,', '')" />
						<!--<xsl:value-of select="translate(Heftnummer, '.&quot; +()/:-äüö,', '')" />-->
						<xsl:text>baf</xsl:text>
						</hierarchy_top_id>
					<hierarchy_top_title>
						<xsl:value-of select="Titel_Hauptband" />
						<xsl:value-of select="Reihe_1" />
						</hierarchy_top_title>
				
					<hierarchy_parent_id>
						<xsl:value-of select="translate(Titel_Hauptband, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(ISBN, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(Reihe_1, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(ISSN, '.&quot; +()/:-äüö,', '')" />
						<xsl:value-of select="translate(Heftnummer, '.&quot; +()/:-äüö,', '')" />
						<xsl:text>baf</xsl:text>
						</hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:choose>
							<xsl:when test="Titel_Hauptband[string-length() != 0]">
								<xsl:value-of select="Titel_Hauptband" />
								</xsl:when>
							<xsl:when test="Hefttitel[string-length() != 0]">
								<xsl:value-of select="Hefttitel"/>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="Reihe_1"/>
								</xsl:otherwise>
							</xsl:choose>
						</hierarchy_parent_title>
				
					<is_hierarchy_id>
						<xsl:value-of select="$id"/><xsl:text>baf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:choose>
							<xsl:when test="Titel_Hauptband[string-length() != 0]">
								<xsl:value-of select="Titel_Hauptband" />
								</xsl:when>
							<xsl:when test="Hefttitel[string-length() != 0]">
								<xsl:value-of select="Hefttitel"/>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="Reihe_1"/>
								</xsl:otherwise>
							</xsl:choose>
						</is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="Titel"></xsl:value-of>
						</hierarchy_sequence>
				
				</hierarchyFields>
			</xsl:element>
		</xsl:if>	



	


</xsl:element>
</xsl:template>








<!--Templates-->
	
	
	<xsl:template match="Heftnummer">
		<xsl:choose>
			<xsl:when test="../Erscheinungsform[text()='Aufsatz']">
				<issue>
					<xsl:value-of select="substring-before(.,'.')"></xsl:value-of>
					</issue>
				</xsl:when>
			<!--<xsl:otherwise>
				<collectionHolding>
					<xsl:value-of select="."></xsl:value-of>
					</collectionHolding>
				</xsl:otherwise>-->
			</xsl:choose>
			
		</xsl:template>
	
	<xsl:template match="Erscheinungsform">
		<xsl:if test=".[text()='Aufsatz']">
			<sourceInfo>
				<xsl:value-of select="../Reihe_1"></xsl:value-of>
				</sourceInfo>
			<xsl:if test="../Heftnummer[string-length() != 0]">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-after(../Heftnummer,'.'))" />
					</displayPublishDate>	
				<publishDate>
					<xsl:value-of select="normalize-space(substring-after(../Heftnummer,'.'))" />
					</publishDate>
				</xsl:if>
			
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Enthaelt">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="Darin">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
		
	<xsl:template match="Bestand">
		<sourceInfo>
			<xsl:value-of select="normalize-space(.)" />
			</sourceInfo>
		</xsl:template>
	
	<!--<xsl:template match="Enthaelt">
		<xsl:variable name="bestand" select="../Bestand[1]" />
		<xsl:variable name="lfr"><xsl:text>Landesfrauenrat</xsl:text></xsl:variable>
		<description>
			<xsl:value-of select="../Bestand[1]"></xsl:value-of>
			<xsl:text>: </xsl:text>
			<xsl:for-each select="../Enthaelt">
				<xsl:value-of select="normalize-space(.)" />
				<xsl:text> </xsl:text>
				</xsl:for-each>
			<xsl:for-each select="../Darin">
				<xsl:value-of select="normalize-space(.)" />
				<xsl:text> </xsl:text>
				</xsl:for-each>
			</description>
		</xsl:template>
	
	<xsl:template match="Darin">
		<xsl:if test="not(../Enthaelt)">
		<xsl:variable name="bestand" select="../Bestand[1]" />
		<xsl:variable name="lfr"><xsl:text>Landesfrauenrat</xsl:text></xsl:variable>
		<description>
			<xsl:value-of select="../Bestand[1]"></xsl:value-of>
			<xsl:text>: </xsl:text>
			<xsl:for-each select="../Darin">
				<xsl:value-of select="normalize-space(.)" />
				<xsl:text> </xsl:text>
				</xsl:for-each>
			</description>
			</xsl:if>
		</xsl:template>-->
	
	<xsl:template match="BAWOrt_Landkreis_Land">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectGeographic>
		</xsl:template>
	
	<xsl:template match="Suchwoerter">
		<xsl:for-each select="tokenize(.,';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Personenregister">
		<xsl:for-each select="tokenize(.,';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)" />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="normalize-space(.)" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Umf_Ill_Beil">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Seite_von_bis">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789-', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Aktentitel[1]">
		<xsl:variable name="bestand" select="../Bestand[1]" />
		<xsl:variable name="lfr"><xsl:text>Landesfrauenrat</xsl:text></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($bestand,$lfr)">
				<title>
					<xsl:value-of select="normalize-space(.)" />
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(.)" />
					</title_short>
				</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="normalize-space(.)" />
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(.)" />
					</title_short>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Titel[1]">
		<title>
			<xsl:if test="../Artikel_die_das[string-length() != 0]">
				<xsl:value-of select="normalize-space(../Artikel_die_das)" />
				<xsl:text> </xsl:text>
				</xsl:if>
			
			<xsl:choose>
				<xsl:when test="contains(.,'==')">
					<xsl:value-of select="normalize-space(substring-after(.,'=='))" />		
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:for-each select="../Titel[position()>=2]">
				<xsl:if test="not(contains(.,'=='))">
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</xsl:if>
				</xsl:for-each>
			</title>
		
		<title_short>
			<xsl:if test="../Artikel_die_das[string-length() != 0]">
				<xsl:value-of select="normalize-space(../Artikel_die_das)" />
				<xsl:text> </xsl:text>
				</xsl:if>
			
			<xsl:choose>
				<xsl:when test="contains(.,'==')">
					<xsl:value-of select="normalize-space(substring-after(.,'=='))" />		
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:for-each select="../Titel[position()>=2]">
				<xsl:if test="not(contains(.,'=='))">
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</xsl:if>
				</xsl:for-each>
			</title_short>
		
		<xsl:if test="../Untertitel[string-length() != 0]">
			<title_sub>
				<xsl:for-each select="../Untertitel">
					<xsl:value-of select="."></xsl:value-of>
					<xsl:text> </xsl:text>
					</xsl:for-each>
				<xsl:for-each select="../Titel_Veranst">
					<xsl:value-of select="."></xsl:value-of>
					<xsl:text> </xsl:text>
					</xsl:for-each>
				</title_sub>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Originaltitel">
		<originalTitle>
			<xsl:value-of select="normalize-space(.)" />
			</originalTitle>	
		</xsl:template>	

	<xsl:template match="ISSN">
		<issn>
			<xsl:value-of select="normalize-space(.)" />
			</issn>	
		</xsl:template>	
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>	
		</xsl:template>	

	<xsl:template match="Laufzeit">
		<displayPublishDate>
			<xsl:value-of select="."/>
			</displayPublishDate>
		<xsl:choose>
			<xsl:when test="contains(.,'-')">
				<xsl:for-each select="tokenize(.,'-')">
					<publishDate>
						<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
						</publishDate>
					</xsl:for-each>
				</xsl:when>
			<xsl:when test="contains(.,';')">
				<xsl:for-each select="tokenize(.,';')">
					<publishDate>
						<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
						</publishDate>
					</xsl:for-each>
				</xsl:when>
			<xsl:otherwise>
				<publishDate>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>	

	<xsl:template match="Jahr">
		<xsl:choose>
			<xsl:when test=".!=''">
				<displayPublishDate>
					<xsl:value-of select="."/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
					</publishDate>
				</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:text>o.A.</xsl:text>
					</displayPublishDate>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>
	
	<xsl:template match="Erscheinungsort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Standort">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
		
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="InventarNeueFrauenbewegung">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="AutorInnen">
	
		<xsl:for-each select="tokenize(.,'/')">
				<xsl:choose>
			<xsl:when test="contains(.,' u.a.')">
				<xsl:for-each select="tokenize(.,'/')">
				<author>
					<xsl:value-of select="normalize-space(substring-before(.,'u.a.'))" />
					</author>
					</xsl:for-each>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
					</xsl:for-each>
	
		</xsl:template>
	
	<xsl:template match="HerausgeberInnen">
		<xsl:for-each select="tokenize(.,'/')">
			<editor>
				<xsl:value-of select="normalize-space(.)" />
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	
	
	
	

</xsl:stylesheet>
