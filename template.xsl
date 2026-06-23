<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat" />

    <xsl:param name="lang">fr</xsl:param>
    <xsl:param name="section">accueil</xsl:param>

    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang}" xml:lang="{$lang}">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>DevOps Portfolio - <xsl:value-of select="portfolio/profil/nom" /></title>
                <style>
                    /* Design Global - Thème Sombre et Rose Moderne */
                    html, body { margin: 0; padding: 0; width: 100%; min-height: 100vh; background-color: #0b0f17; color: #c9d1d9; font-family: 'Segoe UI', system-ui, sans-serif; }
                    .app-container { width: 100%; min-height: 100vh; display: flex; flex-direction: column; }
                    
                    /* Navigation */
                    nav { background: #161b22; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #ff007f; position: sticky; top: 0; z-index: 1000; }
                    .brand-code { font-family: 'Courier New', Courier, monospace; font-weight: bold; color: #ff007f; font-size: 18px; }
                    .menu a { color: #8b949e; text-decoration: none; margin-right: 25px; font-weight: 600; font-size: 14px; transition: color 0.2s; }
                    .menu a:hover { color: #ff007f; }
                    .lang-switcher a { color: #c9d1d9; text-decoration: none; margin-left: 10px; font-weight: bold; padding: 6px 14px; background: #21262d; border: 1px solid #30363d; border-radius: 6px; font-size: 12px; transition: all 0.2s; }
                    .lang-switcher a:hover { background: #ff007f; color: #fff; border-color: #ff007f; box-shadow: 0 0 10px rgba(255, 0, 127, 0.5); }
                    
                    /* Contenu Principal */
                    .main-content { flex: 1; padding: 40px; box-sizing: border-box; width: 100%; max-width: 1200px; margin: 0 auto; }
                    
                    /* Typographie */
                    h2 { font-size: 26px; color: #fff; margin-bottom: 30px; font-weight: bold; margin-top: 40px; border-bottom: 2px solid #ff007f; padding-bottom: 10px; display: inline-block;}
                    h1 { font-size: 42px; color: #fff; margin: 0 0 10px 0; font-weight: 800;}
                    h3 { font-size: 20px; margin: 0 0 10px 0; color: #58a6ff; }
                    
                    /* Design type Blog / Cards */
                    .blog-card { display: flex; gap: 30px; align-items: center; background: #161b22; border: 1px solid #30363d; border-radius: 12px; padding: 25px; margin-bottom: 40px; transition: transform 0.2s, box-shadow 0.2s; }
                    .blog-card:hover { transform: translateY(-3px); box-shadow: 0 8px 24px rgba(0,0,0,0.4); }
                    .blog-image { width: 350px; height: 250px; object-fit: cover; border-radius: 8px; border: 2px solid #ff007f; box-shadow: 0 0 15px rgba(255, 0, 127, 0.2); }
                    .blog-content { flex: 1; }
                    .blog-content p { line-height: 1.8; color: #c9d1d9; font-size: 16px; margin: 0; }

                    /* Style des items classiques */
                    .item { background: #161b22; border: 1px solid #30363d; border-left: 4px solid #ff007f; border-radius: 8px; padding: 25px; margin-bottom: 25px; transition: transform 0.2s; }
                    .item:hover { transform: translateX(5px); border-color: #ff007f; }
                    
                    /* Accueil spécifique */
                    .hero-section { text-align: center; padding: 40px 0; margin-bottom: 20px; }
                    .quote { font-style: italic; color: #8b949e; font-size: 20px; margin: 20px 0; font-weight: 300; }
                    
                    /* Boutons modernes */
                    .btn-action { display: inline-block; margin: 10px; padding: 12px 25px; background: #ff007f; color: #fff; text-decoration: none; border-radius: 30px; font-weight: bold; font-size: 15px; transition: all 0.3s; border: 2px solid #ff007f; }
                    .btn-action:hover { background: transparent; color: #ff007f; box-shadow: 0 0 20px rgba(255, 0, 127, 0.4); }
                    .btn-outline { background: transparent; color: #58a6ff; border-color: #58a6ff; }
                    .btn-outline:hover { background: #58a6ff; color: #fff; box-shadow: 0 0 20px rgba(88, 166, 255, 0.4); }

                    /* Grilles et Listes */
                    .atouts-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
                    .skills-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 20px; }
                    .skill-card { background: #0d1117; padding: 20px; border-radius: 8px; border: 1px solid #30363d; }
                    .skill-card h4 { margin: 0 0 15px 0; color: #fff; font-size: 16px; font-family: monospace; }
                    
                    ul.task-list { margin: 10px 0 0 20px; padding: 0; color: #c9d1d9; }
                    ul.task-list li { margin-bottom: 8px; line-height: 1.5; }
                    ul.task-list li::marker { color: #ff007f; }
                    
                    /* Badges et Tags */
                    .badge { background: #238636; color: #fff; padding: 3px 8px; border-radius: 12px; font-size: 11px; font-weight: bold; margin-left: 10px; vertical-align: middle;}
                    .badge-asso { background: #8957e5; }
                    .tech-tag { display: inline-block; background: #1f2428; border: 1px solid #58a6ff; color: #58a6ff; padding: 5px 10px; border-radius: 6px; font-size: 13px; margin: 0 6px 6px 0; font-family: monospace; }
                    .project-tag { display: inline-block; background: rgba(255, 0, 127, 0.1); border: 1px solid #ff007f; color: #ff007f; padding: 4px 10px; border-radius: 12px; font-size: 12px; margin: 5px 5px 0 0; }
                    
                    /* Accordéon pour expériences additionnelles */
                    details { background: #161b22; border: 1px solid #30363d; border-radius: 8px; padding: 15px; margin-top: 25px; cursor: pointer; }
                    summary { font-weight: bold; color: #58a6ff; font-family: monospace; outline: none; }
                    summary:hover { color: #ff007f; }

                    /* Vidéo */
                    .video-wrapper { position: relative; padding-bottom: 56.25%; height: 0; border-radius: 12px; overflow: hidden; border: 2px solid #30363d; margin-top: 20px;}
                    .video-wrapper iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }

                    /* Media Queries */
                    @media (max-width: 900px) {
                        .blog-card { flex-direction: column; text-align: center; }
                        .blog-image { width: 100%; height: auto; }
                    }
                    @media (max-width: 768px) {
                        nav { flex-direction: column; gap: 15px; }
                        .menu { display: flex; flex-wrap: wrap; justify-content: center; gap: 15px; }
                        .menu a { margin: 0; }
                        h1 { font-size: 32px; }
                    }
                </style>
            </head>
            
            <body vocab="http://xmlns.com/foaf/0.1/" prefix="foaf: http://xmlns.com/foaf/0.1/ dc: http://purl.org/dc/elements/1.1/ schema: http://schema.org/">
                <div class="app-container">
                    <nav>
                        <div class="brand-code">Khejia<span style="color:#fff;">.dev</span></div>
                        <div class="menu">
                            <a href="?lang={$lang}&amp;section=accueil"><xsl:if test="$lang='fr'">Accueil</xsl:if><xsl:if test="$lang='en'">Home</xsl:if><xsl:if test="$lang='zh'">主页</xsl:if></a>
                            <a href="?lang={$lang}&amp;section=experiences"><xsl:if test="$lang='fr'">Expériences</xsl:if><xsl:if test="$lang='en'">Experience</xsl:if><xsl:if test="$lang='zh'">经验</xsl:if></a>
                            <a href="?lang={$lang}&amp;section=formations"><xsl:if test="$lang='fr'">Compétences</xsl:if><xsl:if test="$lang='en'">Skills</xsl:if><xsl:if test="$lang='zh'">技能</xsl:if></a>
                            <a href="?lang={$lang}&amp;section=projets"><xsl:if test="$lang='fr'">Projets</xsl:if><xsl:if test="$lang='en'">Projects</xsl:if><xsl:if test="$lang='zh'">项目</xsl:if></a>
                        </div>
                        <div class="lang-switcher">
                            <a href="?lang=fr&amp;section={$section}">FR</a><a href="?lang=en&amp;section={$section}">EN</a><a href="?lang=zh&amp;section={$section}">ZH</a>
                        </div>
                    </nav>

                    <div class="main-content">
                        <xsl:if test="$section='accueil'">
                            <div class="hero-section">
                                <h1><xsl:value-of select="portfolio/profil/nom" /></h1>
                                <h3 style="color: #ff007f;">
                                    <xsl:value-of select="portfolio/profil/titres/titre[@lang=$lang]" />
                                </h3>
                                <p class="quote">"<xsl:value-of select="portfolio/profil/citations/citation[@lang=$lang]" />"</p>
                                
                                <div style="margin-top: 30px;">
                                    <a href="cv.html" class="btn-action" target="_blank">
                                        <xsl:if test="$lang='fr'">Télécharger mon CV</xsl:if>
                                        <xsl:if test="$lang='en'">Download my CV</xsl:if>
                                        <xsl:if test="$lang='zh'">下载我的简历</xsl:if>
                                    </a>
                                    <a href="mailto:{portfolio/profil/contacts/email}" class="btn-action btn-outline">
                                        <xsl:if test="$lang='fr'">Me contacter</xsl:if>
                                        <xsl:if test="$lang='en'">Contact me</xsl:if>
                                        <xsl:if test="$lang='zh'">联系我</xsl:if>
                                    </a>
                                    <a href="{portfolio/profil/contacts/github}" class="btn-action btn-outline" target="_blank">
                                        <xsl:if test="$lang='fr'">Voir mon GitHub</xsl:if>
                                        <xsl:if test="$lang='en'">View my GitHub</xsl:if>
                                        <xsl:if test="$lang='zh'">浏览我的 GitHub</xsl:if>
                                    </a>
                                </div>
                            </div>
                            
                            <h2>
                                <xsl:if test="$lang='fr'">À propos de moi</xsl:if>
                                <xsl:if test="$lang='en'">About me</xsl:if>
                                <xsl:if test="$lang='zh'">关于我</xsl:if>
                            </h2>
                            <div class="blog-card">
                                <img src="https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=600&amp;q=80" alt="Code &amp; IT" class="blog-image" />
                                <div class="blog-content">
                                    <p>
                                        <xsl:value-of select="portfolio/profil/accroches/accroche[@lang=$lang]" />
                                    </p>
                                </div>
                            </div>

                            <h2>
                                <xsl:if test="$lang='fr'">Mes atouts en bref</xsl:if>
                                <xsl:if test="$lang='en'">My key assets</xsl:if>
                                <xsl:if test="$lang='zh'">我的核心优势</xsl:if>
                            </h2>
                            <div class="blog-card" style="flex-direction: row-reverse;">
                                <img src="https://images.unsplash.com/photo-1573164713988-8665fc963095?ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=600&amp;q=80" alt="Team Coordination" class="blog-image" />
                                <div class="blog-content atouts-grid" style="display: flex; flex-direction: column;">
                                    <xsl:for-each select="portfolio/profil/atouts/atout">
                                        <div style="background: #0d1117; padding: 20px; border-radius: 8px; border-left: 3px solid #58a6ff;">
                                            <h3 style="color: #fff; font-size: 18px; margin-bottom: 5px;">
                                                <xsl:value-of select="titre[@lang=$lang]" />
                                            </h3>
                                            <p style="color: #8b949e; line-height: 1.6; font-size: 15px; margin: 0;">
                                                <xsl:value-of select="description[@lang=$lang]" />
                                            </p>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>

                            <h2>
                                <xsl:if test="$lang='fr'">Visualisation Vidéo</xsl:if>
                                <xsl:if test="$lang='en'">Video Stream</xsl:if>
                                <xsl:if test="$lang='zh'">视频流</xsl:if>
                            </h2>
                            <div class="video-wrapper">
                                <iframe src="https://www.youtube.com/embed/OGg8A2zfWKg?hl={$lang}&amp;cc_lang_pref={$lang}&amp;cc_load_policy=1" 
                                        frameborder="0" 
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                        allowfullscreen="allowfullscreen">
                                </iframe>
                            </div>
                        </xsl:if>

                        <xsl:if test="$section='experiences'">
                            <h2>
                                <xsl:if test="$lang='fr'">Mon Parcours Professionnel &amp; Associatif</xsl:if>
                                <xsl:if test="$lang='en'">Professional &amp; Associative Journey</xsl:if>
                                <xsl:if test="$lang='zh'">职业与协会经历</xsl:if>
                            </h2>
                            <xsl:for-each select="portfolio/experiences/experience">
                                <div class="item">
                                    <h3 style="color: #ff007f;">
                                        <xsl:value-of select="intitules/intitule[@lang=$lang]" />
                                        <xsl:if test="@type='pro'"><span class="badge"><xsl:if test="$lang='fr'">PRO</xsl:if><xsl:if test="$lang='en'">WORK</xsl:if><xsl:if test="$lang='zh'">工作</xsl:if></span></xsl:if>
                                        <xsl:if test="@type='asso'"><span class="badge badge-asso"><xsl:if test="$lang='fr'">ASSO</xsl:if><xsl:if test="$lang='en'">VOLUNTEER</xsl:if><xsl:if test="$lang='zh'">志愿者</xsl:if></span></xsl:if>
                                    </h3>
                                    <p style="color: #8b949e; font-size: 14px; margin-bottom: 10px;">
                                        <strong><xsl:value-of select="entreprise" /></strong> | <xsl:value-of select="dates" />
                                    </p>
                                    <p style="line-height: 1.6; color: #c9d1d9;">
                                        <xsl:value-of select="descriptions/description[@lang=$lang]" />
                                    </p>
                                    <xsl:if test="taches">
                                        <ul class="task-list">
                                            <xsl:for-each select="taches/tache[@lang=$lang]">
                                                <li><xsl:value-of select="." /></li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:if>
                                </div>
                            </xsl:for-each>

                            <details>
                                <summary>
                                    <xsl:if test="$lang='fr'">+ Voir les autres expériences (Jobs étudiants)</xsl:if>
                                    <xsl:if test="$lang='en'">+ View other experiences (Student jobs)</xsl:if>
                                    <xsl:if test="$lang='zh'">+ 查看其他经验（学生工作）</xsl:if>
                                </summary>
                                <p style="padding-top: 15px; color: #8b949e; line-height: 1.5; margin: 0;">
                                    <xsl:if test="$lang='fr'">Emplois étudiants chez Paris Baguette et Kinougarde démontrant adaptabilité, dynamisme et sens des responsabilités au fil des années.</xsl:if>
                                    <xsl:if test="$lang='en'">Student jobs at Paris Baguette and Kinougarde demonstrating adaptability, dynamism, and a sense of responsibility over the years.</xsl:if>
                                    <xsl:if test="$lang='zh'">在 Paris Baguette 和 Kinougarde 的学生工作展示了多年来的适应性、活力和责任感。</xsl:if>
                                </p>
                            </details>
                        </xsl:if>

                        <xsl:if test="$section='formations'">
                            <h2>
                                <xsl:if test="$lang='fr'">Bagage Académique</xsl:if>
                                <xsl:if test="$lang='en'">Academic Background</xsl:if>
                                <xsl:if test="$lang='zh'">学术背景</xsl:if>
                            </h2>
                            <xsl:for-each select="portfolio/formations/formation">
                                <div class="item">
                                    <h3 style="color: #ff007f;"><xsl:value-of select="intitules/intitule[@lang=$lang]" /></h3>
                                    <p style="color: #8b949e; font-size: 14px; margin-bottom: 10px;">
                                        <strong><xsl:value-of select="ecole" /></strong> | <xsl:value-of select="dates" />
                                    </p>
                                    <xsl:if test="descriptions/description">
                                        <p style="color:#c9d1d9; margin-top: 10px; line-height: 1.6;">
                                            <xsl:value-of select="descriptions/description[@lang=$lang]" />
                                        </p>
                                    </xsl:if>
                                </div>
                            </xsl:for-each>

                            <h2 style="margin-top: 40px;">
                                <xsl:if test="$lang='fr'">Stack Technique &amp; Outils</xsl:if>
                                <xsl:if test="$lang='en'">Tech Stack &amp; Tools</xsl:if>
                                <xsl:if test="$lang='zh'">技术栈与工具</xsl:if>
                            </h2>
                            <div class="skills-grid">
                                <xsl:for-each select="portfolio/competences/categorie">
                                    <div class="skill-card">
                                        <h4><xsl:value-of select="titre[@lang=$lang]" /></h4>
                                        <div style="display: flex; flex-direction: column; gap: 15px;">
                                            <xsl:for-each select="item">
                                                <div>
                                                    <span class="tech-tag" property="schema:knowsAbout">
                                                        <xsl:value-of select="nom[@lang=$lang]" />
                                                    </span>
                                                    <!-- Affichage conditionnel de la description -->
                                                    <xsl:if test="details">
                                                        <div style="color: #8b949e; font-size: 13.5px; margin-top: 6px; line-height: 1.5; border-left: 2px solid #30363d; padding-left: 10px;">
                                                            <xsl:value-of select="details[@lang=$lang]" />
                                                        </div>
                                                    </xsl:if>
                                                </div>
                                            </xsl:for-each>
                                        </div>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </xsl:if>

                        <xsl:if test="$section='projets'">
                            <p style="color: #8b949e; margin-bottom: 30px;">
                                <xsl:if test="$lang='fr'">Aperçu des défis techniques relevés lors de ma formation d'ingénieure. Cliquez sur les projets pour voir le code source sur GitHub.</xsl:if>
                                <xsl:if test="$lang='en'">Overview of technical challenges met during my engineering training. Click on projects to see source code on GitHub.</xsl:if>
                                <xsl:if test="$lang='zh'">我的工程培训期间面临的技术挑战概述。点击项目查看 GitHub 上的源代码。</xsl:if>
                            </p>
                            
                            <h2>
                                <xsl:if test="$lang='fr'">Réalisations &amp; Projets</xsl:if>
                                <xsl:if test="$lang='en'">Projects &amp; Achievements</xsl:if>
                                <xsl:if test="$lang='zh'">项目与成就</xsl:if>
                            </h2>
                            <xsl:for-each select="portfolio/projets/projet">
                                <a href="https://github.com/Elianna6" target="_blank" style="text-decoration: none; display: block;">
                                    <div class="item">
                                        <h3 style="color: #ff007f;"><xsl:value-of select="titres/titre[@lang=$lang]" /></h3>
                                        
                                        <p style="line-height: 1.6; color: #c9d1d9; margin-bottom: 10px;">
                                            <xsl:value-of select="descriptions/description[@lang=$lang]" disable-output-escaping="yes" />
                                        </p>
                                        
                                        <xsl:if test="roles/role">
                                            <p style="margin-top: 15px; color: #c9d1d9; line-height: 1.6;">
                                                <strong style="color: #58a6ff;">
                                                    <xsl:if test="$lang='fr'">Mon Rôle &amp; Stack : </xsl:if>
                                                    <xsl:if test="$lang='en'">My Role &amp; Stack: </xsl:if>
                                                    <xsl:if test="$lang='zh'">我的角色与技术栈 : </xsl:if>
                                                </strong>
                                                <xsl:value-of select="roles/role[@lang=$lang]" />
                                            </p>
                                        </xsl:if>
                                        
                                        <xsl:if test="competences_cles/competence">
                                            <p style="margin-top: 10px; color: #c9d1d9; line-height: 1.6;">
                                                <strong style="color: #58a6ff;">
                                                    <xsl:if test="$lang='fr'">Compétence clé : </xsl:if>
                                                    <xsl:if test="$lang='en'">Key Competence: </xsl:if>
                                                    <xsl:if test="$lang='zh'">核心能力 : </xsl:if>
                                                </strong>
                                                <xsl:value-of select="competences_cles/competence[@lang=$lang]" />
                                            </p>
                                        </xsl:if>
                                    </div>
                                </a>
                            </xsl:for-each>
                        </xsl:if>

                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
