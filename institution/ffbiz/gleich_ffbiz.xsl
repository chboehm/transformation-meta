<?xml version="1.0" encoding="UTF-8" ?>
<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes" />

	<!-- Leere Knoten werden entfernt -->
	<xsl:template match="@*[.='']" />
	<xsl:template match="*[not(node())]" />

	<!--Nicht dargestellte Zeichen (sog. "Whitespace") werden im XML Dokument entfernt um Speicherplatz zu sparen -->
	<xsl:strip-space elements="*" />

<!--Der Hauptknoten -->
	<xsl:template match="FFBIZ">
		<xsl:element name="catalog">
			<xsl:apply-templates select="Objekt[1]/erfasstam" />
			<xsl:apply-templates select="Objekt" />
		</xsl:element>
	</xsl:template>

<!--Thesaurusknoten-->
	<xsl:template match="Thesaurus">
		<xsl:element name="catalog">
			<xsl:apply-templates select="concept" />
			<!--<xsl:apply-templates select="Datensatz[1]/id" />-->
			</xsl:element>
		</xsl:template>

<xsl:template match="concept">
		<xsl:element name="record">
			
			<xsl:variable name="top">
				<xsl:choose>
					<xsl:when test="not(broader)">
						<xsl:value-of select="notation" />
					</xsl:when>
					<xsl:when test="not(contains(broader,'.'))">
						<xsl:value-of select="broader" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring-before(broader,'.')" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
				
			<xsl:variable name="broader">
				<xsl:value-of select="broader"></xsl:value-of>
			</xsl:variable>
	<vufind>
		<id>			
			<xsl:choose>
				<!--wenn kein Punkt in der Notation-->
				<xsl:when test="not(contains(notation,'.'))">
					<xsl:value-of select="translate(prefTerm, '. /äüö,', '')" />
					</xsl:when>
				<!--andernfalls-->
				<xsl:otherwise>
					<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
					<xsl:value-of select="translate(prefTerm, '. /äüö,', '')" />
					</xsl:otherwise>
					</xsl:choose>
				<xsl:text>ffbiz</xsl:text>
			</id>
				
		<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
		<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
				
		<recordType>
			<xsl:choose>
				<xsl:when test="not(contains(notation,'.'))">
					<xsl:text>archive</xsl:text>
					</xsl:when>
				<xsl:otherwise>
					<xsl:text>systematics</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</recordType>	
		</vufind>

	<institution>
		<institutionShortname><xsl:text>FFBIZ-Archiv</xsl:text></institutionShortname>
		<institutionFull><xsl:text>Frauenforschungs-, -bildungs- und -informationszentrum FFBIZ e.V.</xsl:text></institutionFull>
		<institutionID><xsl:text>ffbiz</xsl:text></institutionID>
		<collection><xsl:text>ffbiz</xsl:text></collection>
		<isil><xsl:text>DE-B1535</xsl:text></isil>
		</institution>

	<dataset>			
	<!--Title-->
		<title><xsl:value-of select="prefTerm" /></title>
		<title_short><xsl:value-of select="prefTerm" /></title_short>	
	
	<!-- SourceInfo -->
		<xsl:if test="$broader[string-length() != 0]">
			<sourceInfo>
				<xsl:value-of select="//concept[notation=$broader]/prefTerm"></xsl:value-of>
				</sourceInfo>
			</xsl:if>
		</dataset>
			
	<functions>
		<hierarchyFields>
			
			<hierarchy_top_id>
				<xsl:value-of select="translate(//concept[notation=$top]/prefTerm, '. /äüö,', '')" />
				<xsl:text>ffbiz</xsl:text>
			</hierarchy_top_id>
					
			<hierarchy_top_title>
				<xsl:value-of select="//concept[notation=$top]/prefTerm"></xsl:value-of>
			</hierarchy_top_title>

		<xsl:if test="contains(notation,'.')">
			<hierarchy_parent_id>
				<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
				<xsl:text>ffbiz</xsl:text>	
			</hierarchy_parent_id>
				
			<hierarchy_parent_title>
				<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
			</hierarchy_parent_title>
		</xsl:if>
			
			<is_hierarchy_id>
				<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
				<xsl:text>ffbiz</xsl:text>
			</is_hierarchy_id>
					
			<is_hierarchy_title>
					<xsl:value-of select="normalize-space(prefTerm)" />
			</is_hierarchy_title>
					
					
			<hierarchy_sequence>
				<xsl:value-of select="translate(notation, translate(.,'0123456789', ''), '')"/>
			</hierarchy_sequence>
						
		</hierarchyFields>
	</functions>
</xsl:element>
</xsl:template>



<xsl:template match="erfasstam">

		<xsl:for-each select="document('thesaurus.xml')/Thesaurus//concept">

			<xsl:if
				test="(notation|broader='1.1') or
			(notation|broader='1.2') or
			(notation|broader='1.3')">

				<xsl:element name="record">
					<xsl:variable name="broader" select="broader" />
					<vufind>
						<id>
							<xsl:value-of
								select="translate(prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
							<xsl:text>ffbiz</xsl:text>
						</id>
						<recordCreationDate>
							<xsl:value-of select="current-dateTime()" />
						</recordCreationDate>
						<recordChangeDate>
							<xsl:value-of select="current-dateTime()" />
						</recordChangeDate>
						<recordType>
							<xsl:choose>
								<xsl:when test="contains(broader,'.')">
									<xsl:text>systematics</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>archive</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</recordType>
					</vufind>

					<institution>
						<institutionShortname>
							<xsl:text>FFBIZ-Archiv</xsl:text>
						</institutionShortname>
						<institutionFull>
							<xsl:text>Frauenforschungs-, -bildungs- und -informationszentrum FFBIZ e.V.</xsl:text>
						</institutionFull>
						<institutionID>
							<xsl:text>ffbiz</xsl:text>
						</institutionID>
						<collection>
							<xsl:text>ffbiz</xsl:text>
						</collection>
						<isil>
							<xsl:text>DE-B1535</xsl:text>
						</isil>
					</institution>

					<dataset>
						<typeOfRessource>
							<xsl:text>text</xsl:text>
						</typeOfRessource>
						<xsl:if test="not(contains(broader,'.'))">
							<format>
								<xsl:text>Archivgut</xsl:text>
							</format>
							<searchfilter>
								<xsl:text>Bestandsübersicht</xsl:text>
							</searchfilter>
						</xsl:if>
						<title>
							<xsl:value-of select="prefTerm" />
						</title>
						<title_short>
							<xsl:value-of select="prefTerm" />
						</title_short>
						<sourceInfo>
							<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
						</sourceInfo>
					</dataset>

					<functions>
						<hierarchyFields>
							<hierarchy_top_id>
								<xsl:choose>
									<xsl:when test="contains(broader,'.')">
										<xsl:value-of
											select="translate(//concept[notation=$broader]/prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of
											select="translate(prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>ffbiz</xsl:text>
							</hierarchy_top_id>
							<hierarchy_top_title>
								<xsl:choose>
									<xsl:when test="contains(broader,'.')">
										<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="prefTerm" />
									</xsl:otherwise>
								</xsl:choose>
							</hierarchy_top_title>
							<xsl:if test="contains(broader,'.')">
								<hierarchy_parent_id>
									<xsl:value-of
										select="translate(//concept[notation=$broader]/prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
									<xsl:text>ffbiz</xsl:text>
								</hierarchy_parent_id>
								<hierarchy_parent_title>
									<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
								</hierarchy_parent_title>
							</xsl:if>
							<is_hierarchy_id>
								<xsl:value-of
									select="translate(prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
								<!--<xsl:value-of select="translate(notation, translate(.,'0123456789', ''), '')" /> -->
								<xsl:text>ffbiz</xsl:text>
							</is_hierarchy_id>
							<is_hierarchy_title>
								<xsl:choose>
									<xsl:when test="contains(prefTerm,'/')">
										<xsl:value-of select="normalize-space(substring-after(prefTerm,'/'))" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="prefTerm" />
									</xsl:otherwise>
								</xsl:choose>
							</is_hierarchy_title>
							<hierarchy_sequence>
								<xsl:value-of select="translate(notation, translate(.,'0123456789', ''), '')" />
							</hierarchy_sequence>
						</hierarchyFields>
					</functions>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Objekt">
		<xsl:variable name="id" select="id" />
		
		<xsl:if test="objektart[text()='Plakate']">
		<!-- <xsl:if test="not(objektart[text()='Fotografie_n'])"> -->
		
		
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>

<!--vufind_______________________________vufind_______________________________vufind -->

				<xsl:element name="vufind">

					<!--Identifikator -->
					<id>
						<xsl:value-of select="$id" />
						<xsl:text>ffbiz</xsl:text>
					</id>

					<!--recordCreationDate -->
					<recordCreationDate>
						<xsl:value-of select="current-dateTime()" />
					</recordCreationDate>

					<!--recordChangeDate -->
					<recordChangeDate>
						<xsl:value-of select="current-dateTime()" />
					</recordChangeDate>

					<!--recordType -->
					<xsl:choose>
						<xsl:when test="objektart[text()='Bibliothek']">
							<recordType>
								<xsl:text>library</xsl:text>
							</recordType>
						</xsl:when>
						<xsl:when test="objektart[text()='Akten, Graue Materialien, ZD']">
							<recordType>
								<xsl:text>archive</xsl:text>
							</recordType>
						</xsl:when>
						<xsl:when test="objektart[text()='Nachlässe']">
							<recordType>
								<xsl:text>archive</xsl:text>
							</recordType>
						</xsl:when>
						<xsl:otherwise>
							<recordType>
								<xsl:text>library</xsl:text>
							</recordType>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>

				<!--institution_______________________________institution_______________________________institution -->
				<xsl:element name="institution">

					<!--institutionShortname -->
					<institutionShortname>
						<xsl:text>FFBIZ-Archiv</xsl:text>
					</institutionShortname>

					<!--institutionFullname -->
					<institutionFull>
						<xsl:text>Frauenforschungs-, -bildungs- und -informationszentrum FFBIZ e.V.</xsl:text>
					</institutionFull>

					<institutionID>
						<xsl:text>ffbiz</xsl:text>
					</institutionID>

					<!--collection -->
					<collection>
						<xsl:text>ffbiz</xsl:text>
					</collection>

					<!--isil -->
					<isil>
						<xsl:text>DE-B1535</xsl:text>
					</isil>

					<!--linkToWebpage -->
					<link>
						<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/ffbiz/</xsl:text>
					</link>

					<!--geoLocation -->
					<geoLocation>
						<latitude>52.5209210</latitude>
						<longitude>13.4557330</longitude>
					</geoLocation>

				</xsl:element>

				<!--Buch________________Buch___________________________Buch -->
				<xsl:if test="objektart[text()='Bibliothek']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>text</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Buch</xsl:text>
						</format>
						<xsl:choose>
							<xsl:when test="Hrsg_x046x_">
								<searchfilter>
									<xsl:text>Sammelband</xsl:text>
								</searchfilter>
							</xsl:when>
							<xsl:otherwise>
								<searchfilter>
									<xsl:text>Monografie</xsl:text>
								</searchfilter>
							</xsl:otherwise>
						</xsl:choose>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Hauptsachtitel[1]" />
						<!--alternativeTitle -->
						<xsl:apply-templates select="Titel_x132x_nderungen" />
						<xsl:apply-templates select="Einheitssachtitel" />
						<!--RESPONSIBLE -->
						<!--author Autorinneninformation -->
						<xsl:apply-templates select="Verf_x046x_" />
						<!--editor Herausgeberinneninformationen -->
						<xsl:apply-templates select="Hrsg_x046x_" />
						<!--entity Körperschaft -->
						<xsl:apply-templates select="bet_x046x_KS" />
						<xsl:apply-templates select="Urheber" />
						<!--series Reiheninformation -->
						<xsl:apply-templates select="Reihe" />
						<!--edition Auflage -->
						<xsl:apply-templates select="Auflage[1]" />
						<!--volume -->
						<xsl:apply-templates select="Band" />
						<!--IDENTIFIER -->
						<!--ISBN -->
						<xsl:apply-templates select="ISBN" />
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Jahr_x047x_Datierung" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Verlagsort" />
						<!--publisher Verlagsangabe -->
						<xsl:apply-templates select="Verlag" />
						<!--PHYSICAL INFORMATION -->
						<!--physical Seitenangabe -->
						<xsl:apply-templates select="Umfang" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subjectTopic Deskriptoren -->
						<xsl:apply-templates select="Schlagwort_x032x_Bibliothek" />
						<xsl:apply-templates select="Person" />
						<xsl:apply-templates select="Beitr_x132x_ge_x032x_von[1]" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
					
					<functions>
						<hierarchyFields>
						<xsl:variable name="bestand" select="translate(Bestand, '. /äüö,', '')" />
						<xsl:variable name="klassifikation" select="translate(Klassifikation_x032x_Nachl_x132x_sse, '. /äüö,', '')" />
						
						<hierarchy_top_id>
							<xsl:value-of select="$bestand" />
							<xsl:text>ffbiz</xsl:text>
						</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:value-of select="Bestand" />
						</hierarchy_top_title>
							
						<hierarchy_parent_id>
							<xsl:value-of select="$bestand" />
							<xsl:value-of select="$klassifikation" />
							<xsl:text>ffbiz</xsl:text>
						</hierarchy_parent_id>
						
						<hierarchy_parent_title>
							<xsl:value-of select="Klassifikation_x032x_Nachl_x132x_sse" />
						</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="id" />
							<xsl:text>ffbiz</xsl:text>
						</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="Hauptsachtitel" />
						</is_hierarchy_title>
						<hierarchy_sequence>
							<xsl:value-of select="Hauptsachtitel" />
						</hierarchy_sequence>

						</hierarchyFields>
					</functions>
					
				</xsl:if>

				<!--Zeitschriften________________Zeitschriften___________________________Zeitschriften -->
				<xsl:if test="objektart[text()='Zeitschriften']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>text</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Periodika</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Zeitschrift</xsl:text>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Titel_x032x_" />
						<xsl:apply-templates select="Titel_x132x_nderungen" />
						<!--IDENTIFIER -->
						<!--ISBN -->
						<xsl:apply-templates select="ISSN" />
						<xsl:apply-templates select="ZDB-ID" />
						<!-- publicationFrequency -->
						<xsl:apply-templates select="Erscheinungsweise"/>
						<xsl:apply-templates select="Erscheinungszeitraum"/>
						<!--subjectTopic Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<!--description -->
						<xsl:apply-templates select="Vorwort[string-length() != 0]" />
						<xsl:apply-templates select="Bemerkung[string-length() != 0]" />
						<!--collectionHolding -->
						<xsl:apply-templates select="Periodikumbestand[string-length() != 0]" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
				</xsl:if>

				<!--Akten, Graue Materialien, ZD__________Akten, Graue Materialien, ZD -->
				<xsl:if test="objektart[text()='Akten, Graue Materialien, ZD']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>text</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Archivgut</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Akte</xsl:text>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Titel" />
						<!--RESPONSIBLE -->
						<!--entity Körperschaft / Organisation -->
						<xsl:apply-templates select="Organisation" />
						<!--provenance Privinienz -->
						<xsl:apply-templates select="Provenienz" />
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Jahr_x047x_Datierung" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Ort" />
						<!--blockingPeriod Sperrfrist -->
						<xsl:apply-templates select="Sperrfrist" />
						<!--PHYSICAL INFORMATION -->
						<!--physical Seitenangabe -->
						<xsl:apply-templates select="Umfang" />
						<!--CONTENTRELATED INFORMATION -->
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--description -->
						<xsl:apply-templates select="Enth_x132x_lt" />
						<!--sourceInfo -->
						<sourceInfo>
							<xsl:value-of select="Bestand" />
						</sourceInfo>
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
					<functions>
						<xsl:variable name="bestand" select="Bestand" />
						<xsl:variable name="broader" select="document('thesaurus.xml')/Thesaurus//concept[prefTerm=$bestand]/broader" />
						<xsl:variable name="name" select="document('thesaurus.xml')/Thesaurus//concept[notation=$broader]/prefTerm" />
						<hierarchyFields>
							<hierarchy_top_id>
								<xsl:value-of
									select="translate($name,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
								<xsl:text>ffbiz</xsl:text>
							</hierarchy_top_id>
							<hierarchy_top_title>
								<xsl:value-of select="$name" />
							</hierarchy_top_title>
							<hierarchy_parent_id>
								<xsl:value-of
									select="translate(Bestand,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
								<xsl:text>ffbiz</xsl:text>
							</hierarchy_parent_id>
							<hierarchy_parent_title>
								<xsl:value-of select="Bestand" />
							</hierarchy_parent_title>
							<is_hierarchy_id>
								<xsl:value-of select="id" />
								<xsl:text>ffbiz</xsl:text>
							</is_hierarchy_id>
							<is_hierarchy_title>
								<xsl:value-of select="Titel" />
							</is_hierarchy_title>
							<hierarchy_sequence>
								<xsl:value-of select="Titel" />
							</hierarchy_sequence>
						</hierarchyFields>
					</functions>
				</xsl:if>

				<!--Ansichtskarten__________Ansichtskarten____________Ansichtskarten -->
				<xsl:if test="objektart[text()='Ansichtskarten']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>bild</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Visuelle Materialien</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Ansichtskarte</xsl:text>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Einzeltitel" />
						<!--RESPONSIBLE -->
						<!--author Autorinneninformation -->
						<xsl:apply-templates select="UrheberIn" />
						<!--edition -->
						<xsl:apply-templates select="Editions-Nr_x046x_[1]" />
						<!--PUBLISHING -->
						<!--display publishDate Jahresangabe -->
						<!--placeOfPublication Ortsangabe -->
						<!--publisher Verlagsangabe -->
						<xsl:apply-templates select="Druck_x047x_Verlag_x047x_Grafik" />
						<!--PHYSICAL INFORMATION -->
						<!--dimension Ausmaße -->
						<xsl:apply-templates select="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm" />
						<!--specificMaterialDesignation -->
						<xsl:apply-templates select="Bemerkung" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!--description -->
						<xsl:apply-templates select="Bildbeschreibung" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
				</xsl:if>

				<!--Fotografien________Fotografien____________Fotografien -->
				<xsl:if test="objektart[text()='Fotografien']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>bild</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Fotografie</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Fotografie</xsl:text>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Einzeltitel" />
						<!--RESPONSIBLE -->
						<!--author Autorinneninformation -->
						<xsl:apply-templates select="UrheberIn" />
						<!--provenance Privinienz -->
						<xsl:apply-templates select="Provenienz" />
						<!--PUBLISHING -->
						<!--display publishDate Jahresangabe -->
						<xsl:apply-templates select="freie_x032x_Datumseingabe" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Ort" />
						<!--PHYSICAL INFORMATION -->
						<!--dimension Ausmaße -->
						<xsl:apply-templates select="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm" />
						<!--specificMaterialDesignation -->
						<xsl:apply-templates select="Bemerkung[1]" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!--description -->
						<xsl:apply-templates select="Bildbeschreibung" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />

					</xsl:element>
						
					<functions>
						<hierarchyFields>
						<xsl:variable name="bestand" select="translate(Bestand, '. /äüö,', '')" />
						<xsl:variable name="klassifikation" select="translate(Klassifikation_x032x_Nachl_x132x_sse, '. /äüö,', '')" />
						
						<hierarchy_top_id>
							<xsl:value-of select="$bestand" />
							<xsl:text>ffbiz</xsl:text>
						</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:value-of select="Bestand" />
						</hierarchy_top_title>
							
						<hierarchy_parent_id>
							<xsl:value-of select="$bestand" />
							<xsl:value-of select="$klassifikation" />
							<xsl:text>ffbiz</xsl:text>
						</hierarchy_parent_id>
						
						<hierarchy_parent_title>
							<xsl:value-of select="Klassifikation_x032x_Nachl_x132x_sse" />
						</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="id" />
							<xsl:text>ffbiz</xsl:text>
						</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="Einzeltitel" />
						</is_hierarchy_title>
						<hierarchy_sequence>
							<xsl:value-of select="Einzeltitel" />
						</hierarchy_sequence>

						</hierarchyFields>
					</functions>
				
				</xsl:if>

				<!--Buttons und Sticker________Buttons und Sticker____________Buttons und Sticker -->
				<xsl:if test="objektart[text()='Buttons und Sticker']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>bild</xsl:text>
						</typeOfRessource>
						<format>
							<xsl:text>Objekte</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Buttons und Sticker</xsl:text>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Anlass_x047x_Ereignis_x047x_Thema" />
						<!--RESPONSIBLE -->
						<!--entity Körperschaft / Organisation -->
						<xsl:apply-templates select="Veranstalt_x046x__x047x_Hrsg_x046x_" />
						<!--provenance Privinienz -->
						<xsl:apply-templates select="Provenienz" />
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Jahr_x047x_Datierung" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Ort" />
						<!--PHYSICAL INFORMATION -->
						<!--dimension Ausmaße -->
						<xsl:apply-templates select="Format" />
						<!--specificMaterialDesignation -->
						<xsl:apply-templates select="Farben" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!--description -->
						<xsl:apply-templates select="Bildbeschreibung" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
				</xsl:if>

				<!--Filme________Filme____________Filme -->
				<xsl:if test="objektart[text()='Filme']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>bild</xsl:text>
						</typeOfRessource>
						<format>
							<xsl:text>Film</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Film</xsl:text>
						</searchfilter>
						<!--documentType -->
						<xsl:if test="Filmgenre">
							<documentType>
								<xsl:value-of select="Filmgenre" />
							</documentType>
						</xsl:if>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Filmtitel[1]" />
						<!--RESPONSIBLE -->
						<!--provenance Privinienz -->
						<xsl:apply-templates select="Provenienz" />
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Jahr_x047x_Datierung" />
						<!--PHYSICAL INFORMATION -->
						<!--runTime Laufzeit CD -->
						<xsl:apply-templates select="L_x132x_nge" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<xsl:apply-templates select="DarstellerIn"/>
						<xsl:apply-templates select="RegisseurIn"/>
						<!--description -->
						<xsl:apply-templates select="Bemerkung[1]" />
						<xsl:apply-templates select="Serientitel" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
						<xsl:apply-templates select="Erscheinungsform"/>
						<xsl:apply-templates select="Land_x047x_Region"/>
						<xsl:apply-templates select="Ort"/>
						<xsl:apply-templates select="Produktionsfirma_x047x_Urheber_x032x_"/>
					</xsl:element>
				</xsl:if>

				<!--Audios________Audios____________Audios -->
				<xsl:if test="objektart[text()='Audios']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>ton</xsl:text>
						</typeOfRessource>
						<format>
							<xsl:text>Tonträger</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Tonträger</xsl:text>
						</searchfilter>
						<!--documentType -->
						<xsl:if test="Tontr_x132x_ger">
							<documentType>
								<xsl:value-of select="Tontr_x132x_ger" />
							</documentType>
						</xsl:if>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Titel_x047x_Thema" />
						<!-- Untertitel -->
						
						<!--RESPONSIBLE -->
						<!--author Autorinneninformation -->
						<xsl:apply-templates select="AutorIn" />
						<!--provenance Privinienz -->
						<xsl:apply-templates select="Provenienz" />
						<!--contributor Beteiligte Personen -->
						<xsl:apply-templates select="SprecherIn_x047x_S_x132x_ngerIn" />
						<!--contributor Beteiligte Personen -->
						<xsl:apply-templates select="Regie_x047x_Erstellung" />
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Jahr_x047x_Datierung" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Ort" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!-- subjectGeographic -->
						<xsl:apply-templates select="Kontinent"/>
						<xsl:apply-templates select="Land_x047x_Region"/>
						<!--description -->
						<xsl:apply-templates select="Beschreibung" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
						<!-- runTime -->
						<xsl:apply-templates select="L_x132x_nge"/>
						<!-- annotation -->
						<xsl:apply-templates select="Sender"/>
						<xsl:apply-templates select="Serie_x047x_Reihe"/>
						<xsl:apply-templates select="Aufnahmeort_x047x_-anlass"/>
						<xsl:apply-templates select="Typ_x047x_Genre"/>
					</xsl:element>
				</xsl:if>

				<!--Autographen________Autographen____________Autographen -->
				<xsl:if test="objektart[text()='Autographen']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>text</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Archivgut</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Autograf</xsl:text>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Enth_x132x_lt" />
						<!--RESPONSIBLE -->
						<!--author Autorinneninformation -->
						<xsl:apply-templates select="AutorIn" />
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Jahr_x047x_Datierung" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Ort" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!--description -->
						<xsl:apply-templates select="AdressatIn" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
				</xsl:if>

				<!--Nachlässe________Nachlässe____________Nachlässe -->
				<xsl:if test="objektart[text()='Nachlässe']">
					<xsl:element name="dataset">
						<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>text</xsl:text>
						</typeOfRessource>
						<!--format Objektartinformationen -->
						<format>
							<xsl:text>Archivgut</xsl:text>
						</format>
						<searchfilter>
							<xsl:choose>
								<xsl:when test="Vorwort">
									<xsl:text>Nachlass / Vorlass</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>Akte</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</searchfilter>
						<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:choose>
							<xsl:when test="Vorwort">
								<xsl:apply-templates select="Bestand" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="Titel[1]" />
							</xsl:otherwise>
						</xsl:choose>
						<!--PUBLISHING -->
						<!--display / publishDate Jahresangabe -->
						<xsl:apply-templates select="Bestandslaufzeit" />
						<!--placeOfPublication Ortsangabe -->
						<xsl:apply-templates select="Ort" />
						<!--sourceInfo -->
						<xsl:if test="Bestand[string-length() != 0]">
							<sourceInfo>
								<xsl:value-of select="Bestand" />
							</sourceInfo>
						</xsl:if>
						<!--PHYSICAL INFORMATION -->
						<!--dimension Ausmaße -->
						<xsl:apply-templates select="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm" />
						<!--specificMaterialDesignation -->
						<xsl:apply-templates select="Bemerkung" />
						<!--physical Seitenangabe -->
						<xsl:apply-templates select="Umfang" />
						<!--CONTENTRELATED INFORMATION -->
						<!--language Sprachangaben -->
						<xsl:apply-templates select="Sprache" />
						<!--subject Deskriptoren -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
						<xsl:apply-templates select="Person" />
						<!--description -->
						<xsl:apply-templates select="Vorwort" />
						<xsl:apply-templates select="Enth_x132x_lt" />
						<!--OTHER -->
						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
					</xsl:element>
					
					<functions>
						<hierarchyFields>
						<xsl:variable name="bestand" select="translate(Bestand, '. /äüö,', '')" />
						<xsl:variable name="klassifikation" select="translate(Klassifikation_x032x_Nachl_x132x_sse, '. /äüö,', '')" />
						
						<hierarchy_top_id>
							<xsl:value-of select="$bestand" />
							<xsl:text>ffbiz</xsl:text>
						</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:value-of select="Bestand" />
						</hierarchy_top_title>
							
						<hierarchy_parent_id>
							<xsl:value-of select="$bestand" />
							<xsl:value-of select="$klassifikation" />
							<xsl:text>ffbiz</xsl:text>
						</hierarchy_parent_id>
						
						<hierarchy_parent_title>
							<xsl:value-of select="Klassifikation_x032x_Nachl_x132x_sse" />
						</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="id" />
							<xsl:text>ffbiz</xsl:text>
						</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="Titel" />
						</is_hierarchy_title>
						<hierarchy_sequence>
							<xsl:value-of select="Titel" />
						</hierarchy_sequence>

						</hierarchyFields>
					</functions>
				</xsl:if>

<!--Plakate________Plakate____________Plakate -->
				
				<xsl:if test="objektart[text()='Plakate']">
				
					<xsl:element name="dataset">

					<!--FORMAT -->
						<!--typeOfRessource -->
						<typeOfRessource>
							<xsl:text>bild</xsl:text>
						</typeOfRessource>
						<format>
							<xsl:text>Visuelle Materialien</xsl:text>
						</format>
						<searchfilter>
							<xsl:text>Plakat</xsl:text>
						</searchfilter>

					<!--TITLE -->
						<!--title Titelinformationen -->
						<xsl:apply-templates select="Titel[1]" />

					<!--OTHER -->

						<!--shelfMark Signatur -->
						<xsl:apply-templates select="Signatur" />
						<!-- description Beschreibung -->
						<xsl:apply-templates select="Bildbeschreibung"/>
						<!-- editor -->
						<xsl:apply-templates select="Veranstalt_x046x__x047x_Hrsg_x046x_"/>
						<xsl:apply-templates select="Jahr_x047x_Datierung"/>
						<!-- entity -->
						<xsl:apply-templates select="K_x148x_rperschaft"/>
						<!-- placeOfPublication -->
						<xsl:apply-templates select="Ort"/>
						<!-- dimension -->
						<xsl:apply-templates select="Format"/> 
						<!-- subjectGeographic -->
						<xsl:apply-templates select="Kontinent"/>
						<xsl:apply-templates select="Land_x047x_Region"/>
						<!-- subjectTopic -->
						<xsl:apply-templates select="Schlagworte_x032x_Archiv"/>
						<!-- language -->
						<xsl:apply-templates select="Sprache"/>
						<!-- publisher -->
						<xsl:apply-templates select="Druck_x047x_Verlag_x047x_Grafik"/>
						<xsl:apply-templates select="Farben"/>
						<!-- annotation -->
						<xsl:apply-templates select="Anlass_x047x_Ereignis_x047x_Thema"/>
					</xsl:element>
				</xsl:if>
				
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--Templates -->

	<xsl:template match="Periodikumbestand">
		<collectionHolding>
			<xsl:value-of select="." />
		</collectionHolding>
	</xsl:template>

	<xsl:template match="Beitr_x132x_ge_x032x_von">
		<xsl:for-each select="../Beitr_x132x_ge_x032x_von">
			<contributor>
				<xsl:value-of select="normalize-space(substring-before(.,':'))" />
			</contributor>
		</xsl:for-each>
		<xsl:for-each select="../Beitr_x132x_ge_x032x_von">
			<listOfContents>
				<xsl:value-of select="." />
			</listOfContents>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="ZDB-ID">
		<zdbId>
			<xsl:value-of select="." />
		</zdbId>
	</xsl:template>

	<xsl:template match="ISSN">
		<issn>
			<xsl:value-of select="." />
		</issn>
	</xsl:template>

	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="." />
		</isbn>
	</xsl:template>

	<xsl:template match="AdressatIn">
		<description>
			<xsl:text>AdressatIn: </xsl:text>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Eigenh_x132x_nd_x046x__x032x_Unterschrift">
				<xsl:text> - Unterschrift: </xsl:text>
				<xsl:value-of select="normalize-space(../Eigenh_x132x_nd_x046x__x032x_Unterschrift)" />
			</xsl:if>
			<xsl:if test="../Karte">
				<xsl:text> - Karte: </xsl:text>
				<xsl:value-of select="normalize-space(../Karte)" />
			</xsl:if>
		</description>
	</xsl:template>

	<xsl:template match="Farben">
		<specificMaterialDesignation>
			<xsl:value-of select="normalize-space(.)" />
		</specificMaterialDesignation>
	</xsl:template>

	<xsl:template match="Format">
		<dimension>
			<xsl:value-of select="normalize-space(.)" />
		</dimension>
	</xsl:template>

	<xsl:template match="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm">
		<dimension>
			<xsl:if test="../Format">
				<xsl:value-of select="../Format" />
				<xsl:text> - </xsl:text>
			</xsl:if>
			<xsl:value-of select="." />
		</dimension>
	</xsl:template>

	<xsl:template match="Beschreibung">
		<description>
			<xsl:value-of select="normalize-space(.)" />
		</description>
	</xsl:template>

	<xsl:template match="Bildbeschreibung">
		<description>
			<xsl:value-of select="normalize-space(.)" />
		</description>
	</xsl:template>

	<xsl:template match="Sperrfrist">
		<blockingPeriod>
			<xsl:value-of select="." />
		</blockingPeriod>
	</xsl:template>

	<xsl:template match="Ort">
		<placeOfPublication>
			<xsl:value-of select="." />
		</placeOfPublication>
	</xsl:template>

	<xsl:template match="Land_x047x_Region">
		<subjectGeographic>
			<xsl:value-of select="." />
		</subjectGeographic>
	</xsl:template>

	<xsl:template match="Kontinent">
		<subjectGeographic>
			<xsl:value-of select="." />
		</subjectGeographic>
	</xsl:template>

	<xsl:template match="Vorwort">
		<description>
			<xsl:value-of select="." />
			<xsl:if test="../Enth_x132x_lt">
				<xsl:text> Enthält: </xsl:text>
				<xsl:value-of select="../Enthält"></xsl:value-of>
			</xsl:if>
		</description>
	</xsl:template>

	<xsl:template match="Enth_x132x_lt">
		<xsl:choose>
			<xsl:when test="../objektart[text()='Autographen']">
				<title>
					<xsl:value-of select="normalize-space(.)" />
				</title>
				<title_short>
					<xsl:value-of select="normalize-space(.)" />
				</title_short>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(../Vorwort)">
					<description>
						<xsl:value-of select="." />
					</description>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Organisation">
		<entity>
			<xsl:value-of select="." />
		</entity>
	</xsl:template>

	<xsl:template match="Provenienz">
		<provenance>
			<xsl:value-of select="." />
		</provenance>
	</xsl:template>

	<xsl:template match="Band">
		<volume>
			<xsl:value-of select="." />
		</volume>
	</xsl:template>

	<xsl:template match="Urheber">
		<contributor>
			<xsl:value-of select="." />
		</contributor>
	</xsl:template>

	<xsl:template match="bet_x046x_KS">
		<entity>
			<xsl:value-of select="." />
		</entity>
	</xsl:template>

	<xsl:template match="Reihe">
		<series>
			<xsl:value-of select="." />
		</series>
	</xsl:template>

	<xsl:template match="Editions-Nr_x046x_">
		<edition>
			<xsl:value-of select="." />
		</edition>
	</xsl:template>

	<xsl:template match="Auflage">
		<edition>
			<xsl:value-of select="." />
		</edition>
	</xsl:template>

	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Signatur-Nummerierung">
				<xsl:text> </xsl:text>
				<xsl:value-of select="../Signatur-Nummerierung" />
			</xsl:if>
		</shelfMark>
	</xsl:template>

	<xsl:template match="Person">
		<xsl:for-each select=".">
			<subjectPerson>
				<xsl:value-of select="." />
			</subjectPerson>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Schlagworte_x032x_Archiv">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Schlagwort_x032x_Bibliothek">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Sprache">
		<xsl:for-each select=".">
			<language>
				<xsl:value-of select="lower-case(.)" />
			</language>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="L_x132x_nge">
		<runTime>
			<xsl:value-of select="replace(., '&lt;/?\w+[^&lt;]*&gt;', '')" />
		</runTime>
	</xsl:template>

	<xsl:template match="Umfang">
		<xsl:choose>
			<xsl:when test="../objektart[text()='Bibliothek']">
				<physical>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
				</physical>
			</xsl:when>
			<xsl:when test="../objektart[text()='Akten, Graue Materialien, ZD']">
				<physical>
					<xsl:value-of select="normalize-space(.)" />
				</physical>
			</xsl:when>
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(.)" />
				</physical>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Druck_x047x_Verlag_x047x_Grafik">
		<xsl:for-each select="tokenize(., ';')">
			<publisher>
				<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="." />
		</publisher>
	</xsl:template>

	<xsl:template match="Verlagsort">
		<xsl:choose>
			<xsl:when test=".">
				<placeOfPublication>
					<xsl:value-of select="." />
				</placeOfPublication>
			</xsl:when>
			<xsl:otherwise>
				<placeOfPublication>
					<xsl:text>o.A.</xsl:text>
				</placeOfPublication>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="freie_x032x_Datumseingabe">
		<displayPublishDate>
			<xsl:value-of select="." />
		</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
		</publishDate>
	</xsl:template>

	<xsl:template match="Bestandslaufzeit">
		<xsl:choose>
			<xsl:when test="contains(.,'-')">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
				</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
				</publishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
				</publishDate>
			</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="." />
				</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
				</publishDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Jahr_x047x_Datierung">
		<xsl:choose>
			<xsl:when test="contains(.,'-')">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
				</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
				</publishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
				</publishDate>
				<!--<timeSpan> <timeSpanStart><xsl:value-of select="normalize-space(substring-before(.,'-'))" /></timeSpanStart> <timeSpanEnd><xsl:value-of 
					select="normalize-space(substring-after(.,'-'))" /></timeSpanEnd> </timeSpan> -->
			</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="." />
				</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
				</publishDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Veranstalt_x046x__x047x_Hrsg_x046x_">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="." />
			</editor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Regie_x047x_Erstellung">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
				<xsl:text> [Regie]</xsl:text>
			</contributor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="SprecherIn_x047x_S_x132x_ngerIn">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
				<xsl:text> [Sprech.]</xsl:text>
			</contributor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Hrsg_x046x_">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="." />
			</editor>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="UrheberIn">
		<xsl:for-each select=".">
			<xsl:choose>
				<xsl:when test="contains(.,'FotografIn unbekannt')">
					<contributorNoFacet>
						<xsl:value-of select="." />
					</contributorNoFacet>
				</xsl:when>
				<xsl:otherwise>
					<contributor>
						<xsl:value-of select="." />
						<xsl:text> [Fotogr.]</xsl:text>
					</contributor>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!--<xsl:for-each select="."> <contributor> <xsl:value-of select="."/> <xsl:text> [Fotogr.]</xsl:text> </contributor> </xsl:for-each> -->
	</xsl:template>

	<xsl:template match="AutorIn">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="." />
			</author>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Verf_x046x_">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="." />
			</author>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Einheitssachtitel">
		<originalTitle>
			<xsl:value-of select="replace(.,'_','')" />
		</originalTitle>
	</xsl:template>

	<xsl:template match="Titel_x132x_nderungen">
		<alternativeTitle>
			<xsl:value-of select="replace(.,'_','')" />
		</alternativeTitle>
	</xsl:template>

	<xsl:template match="Bestand">
		<title>
			<xsl:value-of select="replace(.,'_','')" />
		</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')" />
		</title_short>
	</xsl:template>

	<xsl:template match="Titel_x047x_Thema">
		<xsl:choose>
			<xsl:when test="../Untertitel[1]">
				<title_sub>
					<xsl:value-of select="replace(../Untertitel[1],'_','')" />
				</title_sub>
			</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="replace(.,'_','')" />
				</title>
			</xsl:otherwise>
		</xsl:choose>
		<title_short>
			<xsl:value-of select="replace(.,'_','')" />
		</title_short>
	</xsl:template>

	<xsl:template match="Titel_x032x_">
		<xsl:choose>
			<xsl:when test="../Untertitel[1]">
				<title_sub>
					<xsl:value-of select="replace(../Untertitel[1],'_','')" />
				</title_sub>
			</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="replace(.,'_','')" />
				</title>
			</xsl:otherwise>
		</xsl:choose>
		<title>
			<xsl:value-of select="replace(.,'_','')" />
		</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')" />
		</title_short>
	</xsl:template>

	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="replace(.,'_','')" />
		</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')" />
		</title_short>
	</xsl:template>

	<xsl:template match="Filmtitel">
		<title>
			<xsl:value-of select="replace(.,'_','')" />
		</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')" />
		</title_short>
	</xsl:template>

	<xsl:template match="Anlass_x047x_Ereignis_x047x_Thema">
		<xsl:choose>
			<xsl:when test="../objektart[text()='Buttons und Sticker']">
				<title>
					<xsl:value-of select="replace(.,'_','')" />
				</title>
				<title_short>
					<xsl:value-of select="replace(.,'_','')" />
				</title_short>
			</xsl:when>
			<xsl:otherwise> <!-- Plakat -->
				<annotation>
					<xsl:text>Anlass: </xsl:text>
					<xsl:value-of select="replace(.,'_','')" />
				</annotation>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Einzeltitel">
		<title>
			<xsl:value-of select="replace(.,'_','')" />
			<xsl:if test="../Untertitel!=''">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
			</xsl:if>
		</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')" />
		</title_short>
		<xsl:if test="../Untertitel!=''">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
			</title_sub>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Hauptsachtitel">
		<title>
			<xsl:value-of select="normalize-space(replace(.,'_',''))" />
			<xsl:if test="../Untertitel!=''">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
			</xsl:if>
		</title>
		<title_short>
			<xsl:value-of select="replace(normalize-space(.),'_','')" />
		</title_short>
		<xsl:if test="../Untertitel!=''">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
			</title_sub>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="K_x148x_rperschaft">
		<entity>
			<xsl:value-of select="replace(.,'_','')" />
		</entity>
	</xsl:template>

	<xsl:template match="Sender">
		<annotation>
			<xsl:text>Sender: </xsl:text>
			<xsl:value-of select="replace(.,'_','')"/>
		</annotation>
	</xsl:template>
	
	<xsl:template match="Serie_x047x_Reihe">
		<annotation>
			<xsl:text>Serie/Reihe: </xsl:text>
			<xsl:value-of select="replace(.,'_','')"/>
		</annotation>
	</xsl:template>
	
	<xsl:template match="Aufnahmeort_x047x_-anlass">
		<annotation>
			<xsl:text>Aufnahmeort/Anlass: </xsl:text>
			<xsl:value-of select="replace(.,'_','')"/>
		</annotation>
	</xsl:template>
	
	<xsl:template match="Typ_x047x_Genre">
		<annotation>
			<xsl:text>Typ/Genre: </xsl:text>
			<xsl:value-of select="replace(.,'_','')"/>
		</annotation>
	</xsl:template>
	
	<xsl:template match="DarstellerIn">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
				<xsl:text> [Darst.]</xsl:text>
			</contributor>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="RegisseurIn">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="." />
				<xsl:text> [Regie]</xsl:text>
			</contributor>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="Produktionsfirma_x047x_Urheber_x032x_">
		<contributor>
			<xsl:value-of select="." />
		</contributor>
	</xsl:template>
	
	<xsl:template match="Erscheinungsform">
		<physical>
			<xsl:value-of select="." />
		</physical>
	</xsl:template>
	
	<xsl:template match="Serientitel">
		<annotation>
			<xsl:text>Serientitel: </xsl:text>
			<xsl:value-of select="." />
		</annotation>
	</xsl:template>
	
	<xsl:template match="Erscheinungsweise">
		<publicationFrequency>
			<xsl:value-of select="." />
		</publicationFrequency>
	</xsl:template>
	
	<xsl:template match="Erscheinungszeitraum">
		<annotation>
			<xsl:text>Erscheinungszeitraum: </xsl:text>
			<xsl:value-of select="." />
		</annotation>
	</xsl:template>
</xsl:stylesheet>