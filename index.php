<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

// 1. GESTION DE LA LANGUE
$langues_disponibles = ['fr', 'en', 'zh'];
$lang = '';

if (isset($_GET['lang']) && in_array($_GET['lang'], $langues_disponibles)) {
    $lang = $_GET['lang'];
} elseif (isset($_POST['lang']) && in_array($_POST['lang'], $langues_disponibles)) {
    $lang = $_POST['lang'];
} elseif (isset($_SESSION['lang']) && in_array($_SESSION['lang'], $langues_disponibles)) {
    $lang = $_SESSION['lang'];
} elseif (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
    $pref_lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
    if (in_array($pref_lang, $langues_disponibles)) {
        $lang = $pref_lang;
    }
}
if (empty($lang)) {
    $lang = 'fr';
}
$_SESSION['lang'] = $lang;

// 2 GESTION DE LA SECTION
$sections_disponibles = ['accueil', 'experiences', 'formations', 'projets'];
$section = 'accueil'; // Page d'accueil par défaut

if (isset($_GET['section']) && in_array($_GET['section'], $sections_disponibles)) {
    $section = $_GET['section'];
}

// 3. CHARGEMENT ET VÉRIFICATION DES FICHIERS XML ET XSL
$xml = new DOMDocument;
if (!$xml->load('portfolio.xml')) {
    die("<h3>Erreur Fatale : Impossible de charger portfolio.xml. Vérifie la syntaxe du fichier.</h3>");
}

$xsl = new DOMDocument;
if (!$xsl->load('template.xsl')) {
    die("<h3>Erreur Fatale : Impossible de charger template.xsl. Vérifie la syntaxe du fichier.</h3>");
}

// 4. TRANSFORMATION XSLT
$processeur = new XSLTProcessor;
$processeur->importStyleSheet($xsl);


$processeur->setParameter('', 'lang', $lang);
$processeur->setParameter('', 'section', $section);

$resultat = $processeur->transformToXML($xml);

if ($resultat === false) {
    die("<h3>Erreur Fatale : La transformation XSLT a échoué.</h3>");
}

header('Content-Type: text/html; charset=utf-8');
echo $resultat;
?>
