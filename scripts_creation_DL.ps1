﻿

New-ADOrganizationalUnit -Name DL -Path "CHEMIN OU POUR STOCKAGE OU DL"

$dom = Get-ADDomain
$DN = "OU=DL," + $dom.DistinguishedName
echo "Entrez le chemin absolu de l'arbo : "
$path = Read-Host 
$arborescence = Get-ChildItem -Path  $path -Recurse
$arborescence.FullName

Foreach ($dossier in $arborescence)
{
	# Création des DL relatives au nom de dossier
	$nom = "DL_"+ $dossier
	New-ADGroup -Name $nom"_R" -GroupScope DomainLocal -Path $DN
	New-ADGroup -Name $nom"_RW" -GroupScope DomainLocal -Path $DN	
}