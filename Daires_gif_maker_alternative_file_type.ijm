title = "Untitled";
extension = ".JPG";
Dialog.create("Options");
Dialog.addString("Title:", title);
Dialog.addString("Extension:", extension);
Dialog.show();
title = Dialog.getString();
extension = Dialog.getString();

macro "openfiles"{
	dir = getDirectory("Choose a Directory") //chose the folder where you've stored your classification outputs
	list = getFileList(dir)
	Array.sort(list)
	a = newArray(list.length)
	for (i = 0; i  < list.length; i++){
		a[i] = dir + list[i];
	}

	for (i = 0; i  < a.length; i++){
		b = a[i];
			if (endsWith(a[i], extension)){
				run("Bio-Formats Importer", "open=b color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
			} else {
				print(b,"not opened, wrong file format");
	}

}

macro "processfiles"{

	list = getList("image.titles");
	for (i = 0; i  < list.length; i++){
		selectWindow(list[i]);
		run("Stack to RGB");
		close(list[i]);
	}

	run("Images to Stack", "method=[Scale (smallest)] name=Stack title=[] use");
	run("8-bit Color", "number=256");

	a = dir + title + extension;
	saveAs("Gif", a);

}




