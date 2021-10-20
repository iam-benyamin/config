rebol [
	title: "conversion de fichier .jpg.pdb vers .jpg"
	author: "Pierre Chevalier (pierre.marie.chevalier@wanadoo.fr)"
]

convert_jpg_pdb_to_jpg: make function! [fichier] [
	if error? try [
		prin "D�but de conversion de "
		print fichier
		fichier_in: to-file fichier
		fichier_out: to-file replace fichier ".jpg.pdb" ".jpg"
		if error? try [delete fichier_out] []
		monport: open/direct/binary fichier_in
		until [
			rien: copy/part monport 8
			(find rien "DBLK")
			]
		i: 0
		if error? try [
			until [
				image: copy/part monport 4096
				write/binary/append fichier_out image
				;%image.jpg image
				rien: copy/part monport 8
				i: i + 1
				(rien == none)
				]
			][
			prin "Fin de conversion de "
			prin fichier
			prin " ; fin du fichier atteinte au bout de "
			prin i
			print "blocs."
			close monport
			]
		][
		print "ouverture f�chier impossible"
		close monport
		]
	]


liste_fichiers: read %.
foreach fichier liste_fichiers [
	if (find fichier ".jpg.pdb") [
		print fichier
		;input
		convert_jpg_pdb_to_jpg fichier
		]
]
