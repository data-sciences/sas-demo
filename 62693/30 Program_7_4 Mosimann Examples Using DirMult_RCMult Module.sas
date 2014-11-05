


	/*
		Forest Pollen Count Example, Mosimann (1962)
    
        Note: Program takes awhile to run.  Please be patient.
	*/

	data pollen_count;
		input t1 t2 t3 @@;
		t4 = 100 - t1 - t2 - t3;
	datalines;
	94	0	5	85	1	12	84	1	12	88	0	9
	75	2	14	91	1	4	97	0	3	94	0	4
	81	2	13	99	1	0	83	0	13	69	7	18
	95	2	3	90	2	8	81	1	15	90	0	8
	89	3	1	91	0	8	81	1	16	86	1	8
	84	5	7	79	1	19	76	2	18	90	0	7
	81	3	10	89	0	7	87	3	7	74	5	16
	97	0	2	95	2	1	91	1	5	82	2	11
	86	1	8	90	3	5	94	0	5	87	3	9
	86	2	11	93	1	6	88	1	11	68	3	26
	82	2	10	90	2	7	93	4	2	77	3	11
	72	1	16	89	2	9	84	0	8	86	2	7
	89	0	9	88	1	9	87	1	12	79	1	11
	93	4	2	99	0	1	89	1	6	87	0	11
	87	1	11	86	1	10	73	0	13	79	1	17
	85	0	12	88	0	7	87	3	8	74	0	19
	91	0	7	91	0	7	94	1	3	80	0	14
	95	1	3	84	0	14	81	2	9	85	3	9
	94	3	3
	;

	ods html;
	%DirMult_RCMult(pollen_count, "Forest Pollen Count Example, Mosimann (1962)");
	ods html close;

