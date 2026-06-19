<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Définition du format de sortie : on veut du HTML5 valide -->
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat" />

    <!-- Déclaration de la variable de langue par défaut (sera écrasée par PHP) -->
    <xsl:param name="lang">fr</xsl:param>

    <!-- Point d'entrée : on commence à lire le fichier XML à la racine -->
    <xsl:template match="/">
        <html lang="{$lang}">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <!-- Utilisation de XPath pour récupérer le bon titre de la page -->
                <title>Portfolio - <xsl:value-of select="portfolio/profil/nom" /></title>
                
                <!-- Exemple de style minimaliste intégré -->
                <style>
                    body { font-family: sans-serif; background: #f5f3ef; color: #1a1a2e; margin: 0; padding: 20px; }
                    nav { margin-bottom: 20px; background: #1a1a2e; padding: 10px; border-radius: 5px; }
                    nav a { color: #c9a96e; text-decoration: none; margin-right: 15px; font-weight: bold; }
                    .section { background: #fff; padding: 20px; margin-bottom: 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
                    h1, h2 { border-bottom: 2px solid #c9a96e; padding-bottom: 5px; }
                </style>
            </head>
            <body>

                <!-- Menu de navigation interactif (Ancres HTML) -->
                <nav>
                    <a href="#accueil">Accueil</a>
                    <a href="#formations">Formations</a>
                    <a href="#projets">Projets</a>
                    <a href="#cv">Mon CV</a>
                </nav>

                <!-- SECTION ACCUEIL -->
                <div id="accueil" class="section">
                    <h1><xsl:value-of select="portfolio/profil/nom" /></h1>
                    <!-- XPath filtre ici selon le paramètre $lang -->
                    <h2><xsl:value-of select="portfolio/profil/titres/titre[@lang=$lang]" /></h2>
                    <p><em><xsl:value-of select="portfolio/profil/accroches/accroche[@lang=$lang]" /></em></p>
                </div>

                <!-- SECTION FORMATIONS -->
                <div id="formations" class="section">
                    <h2>Formations</h2>
                    <!-- Boucle XSLT pour parcourir toutes les formations -->
                    <xsl:for-each select="portfolio/formations/formation">
                        <div>
                            <h3><xsl:value-of select="intitules/intitule[@lang=$lang]" /></h3>
                            <p><strong><xsl:value-of select="ecole" /></strong> (<xsl:value-of select="dates" />)</p>
                        </div>
                    </xsl:for-each>
                </div>

                <!-- SECTION PROJETS -->
                <div id="projets" class="section">
                    <h2>Projets</h2>
                    <xsl:for-each select="portfolio/projets/projet">
                        <div>
                            <!-- On affiche le titre et la description dans la bonne langue -->
                            <h3><xsl:value-of select="titres/titre[@lang=$lang]" /></h3>
                            <p><xsl:value-of select="descriptions/description[@lang=$lang]" /></p>
                        </div>
                    </xsl:for-each>
                </div>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
