<?php
// On démarre la session pour pouvoir mémoriser le choix de l'utilisateur (Critère 3)
session_start();

// ---------------------------------------------------------
// 1. GESTION DE LA LANGUE (Respect strict des priorités)
// ---------------------------------------------------------
$langues_disponibles = ['fr', 'en', 'zh'];
$langue_par_defaut = 'fr'; // Critère 5
$lang = '';

// Priorité 1 : Paramètre GET (?lang=zh)
if (isset($_GET['lang']) && in_array($_GET['lang'], $langues_disponibles)) {
    $lang = $_GET['lang'];
} 
// Priorité 2 : Paramètre POST (Bouton de formulaire)
elseif (isset($_POST['lang']) && in_array($_POST['lang'], $langues_disponibles)) {
    $lang = $_POST['lang'];
} 
// Priorité 3 : Variable de session (Choix précédent mémorisé)
elseif (isset($_SESSION['lang']) && in_array($_SESSION['lang'], $langues_disponibles)) {
    $lang = $_SESSION['lang'];
} 
// Priorité 4 : Analyse des préférences du navigateur (HTTP_ACCEPT_LANGUAGE)
elseif (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
    $pref_lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
    if (in_array($pref_lang, $langues_disponibles)) {
        $lang = $pref_lang;
    }
}

// Priorité 5 : Langue par défaut si aucun critère précédent n'est rempli
if (empty($lang)) {
    $lang = $langue_par_defaut;
}

// On mémorise la langue trouvée pour la prochaine page
$_SESSION['lang'] = $lang;


// ---------------------------------------------------------
// 2. TRANSFORMATION XSLT (Le cœur du Web Sémantique)
// ---------------------------------------------------------

// A. Chargement du document XML (Vos données)
$xml = new DOMDocument;
$xml->load('portfolio.xml');

// B. Chargement du document XSLT (Votre maquette)
$xsl = new DOMDocument;
$xsl->load('template.xsl');

// C. Configuration du processeur de transformation
$processeur = new XSLTProcessor;
$processeur->importStyleSheet($xsl);

// D. On injecte la variable de langue dans le fichier XSLT
// C'est ce qui permet à XPath de faire : titre[@lang=$lang]
$processeur->setParameter('', 'lang', $lang);

// E. Génération et affichage du HTML5 final
header('Content-Type: text/html; charset=utf-8');
echo $processeur->transformToXML($xml);
?>
