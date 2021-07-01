#===================================#
# Exemple :
#  "Entrez le chemin absolu de l'arbo : E:\"
# Crée tout les DL correspondant a ce qui a en DESSOUS de E:\ mais ne crée pas de DL pour E:\ 
#
# "Entrez le chemin absolu de l'arbo : E:\Entite"
# Crée tout les DL correspondant a ce qui a en DESSOUS de E:\Entite mais ne crée pas de DL pour Entite
#===================================#


New-ADOrganizationalUnit -Name DL -Path "CHEMIN OU POUR STOCKAGE OU DL ex: ou=entite,dc=domaine,dc=fr"

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
