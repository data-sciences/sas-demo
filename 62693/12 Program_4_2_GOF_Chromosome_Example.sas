



		title;
		*--------------------------------------------------------*
		| This Macro performs a Pearson's GOF Test               |
		| Skellam's (1948) Chromosome Data Example               |
		|  data = data set containing the variables Obs and Pred |
		|    df = degrees of freedom                             |
		| title = Distribution being fit                         |
		*--------------------------------------------------------*;
		%macro gof(data,df,title); 
		proc iml;
			use &data;
			read all var{freq} into Observed;
			read all var{Pred} into Predicted;

			gof    = sum( Observed # Observed / Predicted ) - &n;
			pvalue = 1 - probchi( gof,&df,0 );

			Summary      = j(3,1,0);
			Summary[1,1] = gof;
			Summary[2,1] = &df;
			Summary[3,1] = pvalue;

			label = { 'Pearson''s GOF Test', 
			          'Degrees of Freedom', 
			           'P-value'};
			print &title;
			print Observed Predicted[format=10.4];
			print Summary[rowname=label format=10.4];
		quit;
		%mend gof;

		ods html;
		%gof(pred1,2,'Binomial Distribution');
		%gof(pred2,1,'Beta-binomial Distribution');
		%gof(pred3,1,'Random-clumped Binomial Distribution');
		%gof(pred4,1,'Zero-Inflated Binomial Distribution');
		%gof(pred5,1,'Generalized-Binomial Distribution -- Additive Interaction');
		ods html close;






