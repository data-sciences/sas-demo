 /*-------------------------------------------------------------------*
  *    From "SAS System for Statistical Graphics, First Edition"      *
  *    Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA         *
  *-------------------------------------------------------------------*
  * This material is  provided "as is" by SAS  Institute Inc.  There  *
  * are no warranties, express or  implied, as to merchantability or  *
  * fitness for a particular purpose regarding the materials or code  *
  * contained herein.   The Institute is not  responsible for errors  *
  * in this  material as it now  exists or will exist,  nor does the  *
  * Institute  provide  technical  support  for  it.   Questions  or  *
  * problem reports concerning this material may be addressed to the  *
  * author, Michael Friendly, by electronic mail:                     *
  *                                                                   *
  *        Internet: <FRIENDLY@.YorkU.CA>                             *
  *                                                                   *
  *-------------------------------------------------------------------*/

/* Michael Friendly                                  York University  */

/*  SAS Macro Programs for Statistical Graphics      October 30, 1991 */

/* -----------------------------------------------------------------  */


 This document describes the SAS macro programs included in
 Appendix A1 in SAS System for Statistical Graphics, First
 Edition.  Section references contained here indicate the sections
 in the book where the macro programs are illustrated.

 In some cases there are minor differences between the programs on
 this diskette and those in the appendix.  These changes were made
 to account for minor syntax differences between Version 5 and Version 6
 of the SAS System.  The changes should not affect the appearance of
 graphs produced by the programs.

 In cases where syntax changes between versions of the SAS System made
 it impossible for a single version of a macro program to produce the
 same results under all releases, two versions of the program have been
 provided on this diskette; one to be used with Version 5 of the SAS
 System, and one to be used with Version 6.  Both versions of each macro
 have the same macro names, the same parameter lists, and should produce
 identical results.

 Program Requirements

 The programs were developed under the VM/SP CMS mainframe version of
 the SAS System, Version 5.18.  Where there is a single version of the
 program, the program should run under all releases (5.18 and later) of
 the SAS System on all operating systems.  Where there are two versions
 of a macro provided, one version should run under Release 5.18 on all
 operating systems, and the other should run under all Version 6
 releases on all systems.  The programs all require the base SAS and
 SAS/GRAPH products; many require SAS/STAT and SAS/IML or both as well.

 General Usage Notes

 You may receive unanticipated results if you use multiple macros in
 a single SAS session, because global statement parameters set in one
 macro may be carried over to subsequent macros used in the same
 session.  If you are using Version 6 of the SAS system, we recommend
 adding the statment

      GOPTIONS RESET=ALL;

 to the beginning of each macro.  Under Release 5.18, you can modify
 SYMBOL and PATTERN statements to explicitly specify null values for
 parameters (V=NONE, for example).

 The macros were originally written to produce hardcopy output on a
 white background, and some use black as a foreground color.  If you
 are using the macros to generate graphics on a device with a black
 background, you may need to change all references to BLACK in the
 macro to another color.

 Macro Programs

 BIPLOT    Implements the biplot technique (e.g., Gabriel, 1971)
           for plotting multivariate observations and variables
           together in a single display.

 BOXANNO   Provides univariate marginal boxplot annotations for
           two-dimensional and three-dimensional scatterplots.

 BOXPLOT   Produces standard and notched boxplots for a single
           response variable with one or more grouping variables.

 CONTOUR   The CONTOUR macro plots a bivariate scatterplot with a
           bivariate data ellipse for one or more groups with one
           or more confidence coefficients.

 CORRESP   Performs correspondence analysis (also known as "dual
           scaling") on a table of frequencies in a two-way (or
           higher-way) classification.  In Version 6 of the SAS
           System, this analysis is also performed by PROC
           CORRESP.  This version of the macro should only be used
           with Version 5 of the SAS System.

 CORRESP2  A version of the CORRESP macro that should be used with
           Version 6 of the SAS System.

 DENSITY   Calculates a nonparametric density estimate for
           histogram smoothing of a univariate data distribution
           The program uses the Gaussian kernel and calculates an
           optimal window half-width (Silverman, 1986) if not
           specified by the user.

 DOTPLOT   Produces grouped and ungrouped dot charts of a single
           variable.  (Cleveland, 1984, 1985).

 LOWESS    Performs robust, locally weighted scatterplot smoothing
           (Cleveland, 1979).

 LOWESS2   A version of the LOWESS macro that should be used with
           Version 6 of the SAS System.

 NQPLOT    Produces theoretical normal quantile-quantile (Q-Q)
           plots for single variable.  Options provide a classical
           (mu, sigma) or robust (median, IQR) comparison line,
           standard error envelope, and a detrended plot.

 OUTLIER   Multivariate outlier detection.  The OUTLIER macro
           calculates robust Mahalanobis distances by iterative
           multivariate trimming (Gnanadesikan & Kettenring, 1972;
           Gnanadesikan, 1977), and produces a chisquare Q-Q plot.

 PARTIAL   Partial regression residual plots.  Observations with
           high leverage and/or large studentized residuals can be
           individually labeled.  This version of the macro should
           only be used with Version 5 of the SAS System.

 PARTIAL2  A version of the PARTIAL macro that should be used with
           Version 6 of the SAS System.

 SCATMAT   Draws a scatterplot matrix for all pairs of variables.
           A classification variable may be used to assign the
           plotting symbol and/or color of each point.

 STARS     Draws a star plot of the multivariate observations in a
           data set.  Each observation is depicted by a star-
           shaped figure with one ray for each variable, whose
           length is proportional to the size of that variable.

 SYMPLOT   Produces a variety of diagnostic plots for assessing
           symmetry of a data distribution and finding a power
           transformation to make the data more symmetric.

 TWOWAY    Analysis of two-way tables.  The TWOWAY macro carries
           out analysis of two-way experimental design data with
           one observation per cell, including Tukey's (1949) 1
           degree of freedom test for non-additivity.  Two plots
           may be produced: a graphical display of the fit and
           residuals for the additive model, and a diagnostic plot
           for a power transformation for removable non- additivity.
           This version of the macro should only be used with
           Version 5 of the SAS System.

 TWOWAY2   A version of the TWOWAY macro that should be used with
           Version 6 of the SAS System.


                        SAS Macro Programs

    All of the macro programs use keywords for the required and
 optional parameters. Default values (if any) are given after the
 "=" sign in the parameter list.  Thus, it is only necessary to
 specify parameters which differ from the default value, and these
 parameters may be specified in any order in the macro call.  The
 following conventions (which generally follow SAS usage in PROC
 steps) are used for naming parameters and default values:

 Parameter Description

 DATA=     The name of the input data set to be analyzed or
           plotted.  The default is usually DATA=_LAST_, which


           means that the most recently created data set is the
           default if no data set is specified.

 VAR=      The name(s) of the input variable(s) in the DATA= data
           set.  VAR=_NUMERIC_ means that all numeric variables in
           the data set are analyzed if no variables list is
           specified.  Some of the macros understand a variable
           list specified as a range of variables, such as
           VAR=X1-X5, or VAR=EDUC--INCOME, as in the VAR
           statement.  Others, especially those using PROC IML,
           require the variables to be listed individually, for
           example VAR=X1 X2 X3 X4 X5.

 ID=       The name of an input variable used to label
           observations.  There is usually no default ID variable.

 CLASS=
 GROUP=    Specifies the name of an input variable used to
           classify observations into groups.

 OUT=      The name of the output data set created by the macro.
           OUT=_DATA_ means that the output data set is named
           automatically according to the DATAn convention: the
           first such data set created is called DATA1, the second
           is called DATA2, and so on.  Typically this contains
           the data which is plotted.  In some cases the macro
           leaves it to the user to plot the OUT= data set, so
           that axis labels, values, and ranges can be controlled.

 ANNO=     The name of an input or output data set used for
           annotating the plot.

 NAME=     The name assigned to the graph(s) in the graphic
           catalog.  The default is usually the name of the macro.

 GOUT=     Specifies the name of the graphics catalog used to save
           the output for later replay. The default is WORK.GSEG,
           which is erased at the end of your session.  To save
           graphs in a permanent catalog, use a two-part name.

    In the listings below, each of the macro parameters is briefly
 described in the comment at the right of the program line in the
 %MACRO statement.  Where further description is necessary, it is
 given in the section labeled Parameters.


 BIPLOT macro

 The BIPLOT macro uses PROC IML to carry out the calculations for
 the biplot display described in Section 8.7.  The program
 produces a printer plot of the observations and variables by
 default, but does not produce a PROC GPLOT graph, since a proper
 graph should equate the axes.  Instead, the coordinates to be
 plotted and the labels for observations are returned in two data
 sets, specified by the parameters OUT= and ANNO=, respectively.
 A typical plotting step, using the defaults OUT=BIPLOT and
 ANNO=BIANNO would be:

      proc gplot data=BIPLOT;
         plot dim2 * dim1 / anno=BIANNO frame href=0 vref=0
                            vaxis=axis2 haxis=axis1 vminor=1
      hminor=1;
         axis1 length=5 in offset=(2) label=(h=1.5 'Dimension 1');
         axis2 length=5 in offset=(2) label=(h=1.5 a=90 r=0
      'Dimension 2');
         symbol v=none;

 The axes in the plot should be equated.

 Parameters

 DATA=_LAST_     Name of the input data set for the biplot.

 VAR =_NUMERIC_  Variables for biplot.  The list of variables must
                 be given explicitly; the range notation X1-Xn
                 cannot be used.

 ID  =ID         Name of a character variable used to label the
                 rows (observations) in the biplot display.

 DIM =2          Number of biplot dimensions.

 FACTYPE=SYM     Biplot factor type: GH, SYM, or JK

 SCALE=1         Scale factor for variable vectors.  The
                 coordinates for the variables are multiplied by
                 this value.

 OUT =BIPLOT     Output data set containing biplot coordinates.

 ANNO=BIANNO     Output data set containing Annotate labels.

 STD=MEAN        Specifies how to standardize the data matrix
                 before the singular value decomposition is
                 computed.  If STD=NONE, only the grand mean is
                 subtracted from each value in the data matrix.
                 This option is typically used when row and column
                 means are to be represented in the plot, as in
                 the diagnosis of two-way tables (Section 7.6.3).


                 If STD=MEAN, the mean of each column is
                 subtracted.  This is the default, and assumes
                 that the variables are measured on commensurable
                 scales.  If STD=STD, the column means are
                 subtracted and each column is standardized to
                 unit variance.

 PPLOT=YES       Produce printer plot?  If PPLOT=YES, the first
                 two dimensions are plotted.

 The OUT= data set

 The results from the analysis are saved in the OUT= data set.
 This data set contains two character variables (_TYPE_ and
 _NAME_) which identify the observations and numeric variables
 (DIM1, DIM2, ...)  which give the coordinates of each point.

    The value of the _TYPE_ variable is 'OBS' for the observations
 that contain the coordinates for the rows of the data set, and is
 'VAR' for the observations that contain the coordinates for the
 columns.  The _NAME_ variable contains the value of ID= variable
 for the row observations and the variable name for the column
 observations in the output data set.

 Missing data

 The program makes no provision for missing values on any of the
 variables to be analyzed.


 BOXANNO macro

 BOXANNO SAS contains two SAS macros to annotate a scatterplot
 with marginal boxplots of one or more of the variables plotted
 with either PROC GPLOT or PROC G3D.

 BOXAXIS   Creates an Annotate data set to draw a boxplot for one
           axis in a 2D or 3D scatterplot.

 BOXANNO   Uses two calls to BOXAXIS to create an Annotate data
           set for boxplots on both axes.

 Use BOXANNO to draw the boxplots for both variables in a
 scatterplot.  For a G3D scatterplot, use one call to BOXANNO for
 two of the variables and BOXAXIS for the third.  See the examples
 in Section 4.5.

 Parameters for BOXAXIS

 DATA=_LAST_     Name of the input data set

 OUT=_DATA_      Name of the output Annotate data set


 VAR=            Variable for which a boxplot is constructed

 BAXIS=X         Axis on which it goes.  Must be X, Y, or Z.

 OAXIS=Y         The other axis in the plot

 PAXIS=Z         The 3rd axis (ignored in GPLOT)

 BOXWIDTH=4      Width of the box in percent of the data range

 POS=98          Position of the center of the box on OAXIS in
                 data percent.  POS - BOXWIDTH/2 and POS +
                 BOXWIDTH/2 must both be between 0 and 100.

 Parameters for BOXANNO

 DATA=_LAST_     Data set to be plotted

 XVAR=           Horizontal variable

 YVAR=           Vertical variable

 OUT=BOXANNO     Output Annotate data set


 BOXPLOT macro

 The BOXPLOT macro draws side-by-side boxplots for the groups
 defined by one or more grouping (CLASS) variables in a data set.

 Parameters

 DATA=_LAST_     Name of the input data set.

 CLASS=          Grouping variable(s).  The CLASS= variables can
                 be character or numeric.

 VAR=            The name of the variable to be plotted on the
                 ordinate.

 ID=             A character variable to identify each
                 observation.  If an ID= variable is specified,
                 outside variables are labelled on the graph,
                 using the first 8 characters of the value of the
                 ID variable (to reduce overplotting).  Otherwise,
                 outside points are not labelled.

 WIDTH=.5        Box width as proportion of the maximum.  The
                 default, WIDTH=.5, means that the maximum box
                 width is half the spacing between boxes.


 NOTCH=0         Specifies whether or not to draw notched boxes.
                 1=draw notched boxes; 0=do not.

 CONNECT=0       Specifies the line style used to connect medians
                 of adjacent groups.  If CONNECT=0, the medians of
                 adjacent groups are not to be connected.

 F=0.5           For a notched boxplot, the parameter F determines
                 the notch depth, from the center of the box as a
                 fraction of the halfwidth of each box.  F must be
                 between 0 and 1; the larger the value, the less
                 deep is the notch.

 FN=1            Box width proportionality factor.  The default,
                 FN=1 means all boxes are the same width.  If you
                 specify FN=sqrt(n), the boxes width will be
                 proportional to the square root of the sample
                 size of each group.  Other functions of n are
                 possible as well.

 VARFMT=         The name of a format for the ordinate variable.

 CLASSFMT=       The name of a format for the class variable(s).
                 If the CLASS variable is a character variable, or
                 there are two or more CLASS variables, the
                 program maps the sorted values of the class
                 variable(s) into the integers 1, 2, ... levels,
                 where levels is the number of distinct values of
                 the class variable(s).  A format provided for
                 CLASSFMT should therefore provide labels
                 corresponding to the numbers 1, 2, ... levels.

 VARLAB=         Label for the ordinate variable.  If not
                 specifed, the ordinate is labelled with the
                 variable name.

 CLASSLAB=       Label for the class variable(s) used to label the
                 horizontal axis.

 YORDER=         Tick marks, and range for ordinate, in the form
                 YORDER = low TO high BY tick.

 ANNO=           The name of an (optional) additional ANNOTATE
                 data set to be used in drawing the plot.

 OUT=BOXSTAT     Name of the output data set containing statistics
                 used in drawing the boxplot.  There is one
                 observation for each group.  The variables are N,
                 MEAN, MEDIAN, Q1, Q3, IQR, LO_NOTCH, HI_NOTCH,
                 LO_WHISK, HI_WHISK.


 NAME=BOXPLOT    The name assigned to the graph in the graphic
                 catalog.

 GOPTIONS required

 If there are many groups and/or the formatted labels of group
 names are long, you may need to increase the HPOS= option to
 allow a sufficient number of character positions for the labels.


 CONTOUR macro

 The CONTOUR macro plots a bivariate scatterplot with a bivariate
 data ellipse for one or more groups.

 Parameters

 DATA=_LAST_     Name of the input data set

 X=              Name of the X variable

 Y=              Name of the Y variable

 GROUP=          Group variable.  If a GROUP= variable is
                 specified, one ellipse is produced for each value
                 of this variable in the data set.  If no GROUP=
                 variable is specified, a single ellipse is drawn
                 for the entire sample.  The GROUP= variable may
                 be character or numeric.

 PVALUE=.5       Confidence coefficient(s) ( 1 - alpha ).  This is
                 the proportion of data from a bivariate normal
                 distribution contained within the ellipse.
                 Several values may be specified in a list (e.g.,
                 PVALUE=.5 .9), in which case one ellipse is
                 generated for each value.

 STD=STDERR      Error bar metric.  STD=STDERR gives error bars
                 equal to each mean +- one standard error (s  /
                 sqrt n) for both variables.  STD=STD gives error
                 bars whose length is one standard deviation for
                 both variables.

 POINTS=40       The number of points on each contour.

 ALL=NO          Specifies whether the contour for the total
                 sample should be drawn in addition to those for
                 each group.  If there is no GROUP= variable,
                 ALL=YES just draws the ellipse twice.

 OUT=CONTOUR     Name of the output Annotate data set used to draw
                 the ellipses, error bars and group labels.


 PLOT=YES        If YES, the macro plots the data together with
                 the generated ellipses.  Otherwise, only the
                 output Annotate data set is generated.

 I=NONE          SYMBOL statement interpolate option for drawing
                 points.  Use I=RL to include the regression line
                 as well.

 NAME=CONTOUR    The name assigned to the graph(s) in the graphic
                 catalog.

 COLORS=RED GREEN BLUE BLACK PURPLE YELLOW BROWN ORANGE
                 List of colors to use for each of the groups.  If
                 there are g groups, specify g colors if ALL=NO,
                 and g  +  1 colors if ALL=YES.  COLORS(i) is used
                 for group i.

 SYMBOLS=+ SQUARE STAR - PLUS : $ =
                 List of symbols, separated by spaces, to use for
                 plotting points in each of the groups.
                 SYMBOLS(i) is used for group i.


 Usage Notes

 When using the CONTOUR macro with the SAS System for Personal
 Computers, it may be neccessary to add the option WORKSIZE=100 to
 the PROC IML statement.

 When displaying output from the macro on a terminal, you should change
 occurences of the color BLACK to WHITE.

 CORRESP macro

 CORRESP performs correspondence analysis on a table of
 frequencies in a two-way (or higher-way) classification.  The
 VAR= variables list specify one of the classification variables.
 The observations in the input data set form the other
 classification variable(s).

    The coordinates of the row and column points are output to the
 data set specified by the OUT= parameter.  The labels for the
 points are output to the data set specified by the ANNO=
 parameter.  See Section 10.3.2 for details about plotting the
 results and equating axes.


 Parameters

 DATA=_LAST_     Name of the input data set

 VAR=            Column variables

 ID=             ID variable: row labels

 OUT=COORD       Output data set for coordinates

 ANNO=LABEL      Name of the Annotate data set for row and column
                 labels

 ROWHT=1         Height (in character cells) for the row labels

 COLHT=1         Height (in character cells) for the column labels


 The OUT= data set

 The results from the analysis are saved in the OUT= data set.
 This data set contains two character variables (_TYPE_ and
 _NAME_) which identify the observations and two numeric variables
 (DIM1 and DIM2) which give the locations of each point in two
 dimensions.

    The value of the _TYPE_ variable is 'OBS' for the observations
 that contain the coordinates for the rows of the table, and is
 'VAR' for the observations that contain the coordinates for the
 columns.  The _NAME_ variable contains the value of ID= variable
 for the row observations and the variable name for the column
 observations in the output data set.


 DENSITY macro

 The DENSITY macro calculates a nonparametric density estimate of
 a data distribution as described in Section 3.4.  The macro
 produces the output data set specified by the OUT= parameter, but
 leaves it to the user to call PROC GPLOT, so that the plot can be
 properly labeled.  The output data set contains the variables
 DENSITY and WINDOW in addition to the variable specified by the
 VAR= parameter.

    A typical plotting step, using the defaults, OUT=DENSPLOT and
 VAR=X, would be:

      proc gplot data=densplot;
         plot density * X ;
         symbol1 i=join v=none;

 Parameters

 DATA=_LAST_     Name of the input data set

 OUT=DENSPLOT    Name of the output data set

 VAR=X           Name if the input variable (numeric)

 WINDOW=         Bandwidth (H) for kernel density estimate

 XFIRST=.        Smallest X value at which density estimate is
                 computed.  If XFIRST = ., the minimum value of
                 the VAR= variable is used.

 XLAST=.         Largest X value at which density estimate is
                 computed.  If XLAST = ., the maximum value of the
                 VAR= variable is  used.


 XINC=.          Step-size (increment) for computing density
                 estimates.  If XINC = ., the increment is
                 calculated as values, XINC = (XLAST-XFIRST)/60.


 DOTPLOT macro

 DOTPLOT produces grouped and ungrouped dot charts, as described
 in Section 2.5.

 Parameters

 DATA=_LAST_     Name of the input data set

 XVAR=           Horizontal (response) variable

 XORDER=         Plotting range for response.  Specify XORDER in
                 the form XORDER = low TO high BY step.

 XREF=           Specifies the horizontal values at which
                 reference lines are drawn for the response
                 variable.  If not specified, no reference lines
                 are drawn.

 YVAR=           Vertical variable (observation label) for the dot
                 chart.  This should specify a character variable.
                 At most 16 characters of the value are used for
                 the label.

 YSORTBY=&XVAR   How to sort the observations.  The default,
                 YSORTBY=&XVAR, indicates that observations are
                 sorted in ascending order of the response
                 variable.

 YLABEL=         Label for y variable.  If not specified, the
                 vertical axis is labelled with the name of the
                 YVAR= variable.

 GROUP=          Vertical grouping variable.  If specified, a
                 grouped dot chart is produced with a separate
                 panel for each value of the GROUP= variable.

 GPFMT=          format for printing group variable value (include
                 the "." at the end of the format name).

 CONNECT=DOT     Specifies how to draw horizontal lines for each
                 observation.  Valid values are ZERO, DOT, AXIS,
                 or NONE.  The default, CONNECT=DOT, draws a
                 dotted line from the Y axis to the point.
                 CONNECT=ZERO draws a line from an X value of 0 to
                 the point.  CONNECT=AXIS draws a line from the Y
                 axis to the plot frame at the maximum X value.


                 CONNECT=NONE does not draw a line for the
                 observation.

 DLINE=2         Line style for horizontal lines for each
                 observation.

 DCOLOR=BLACK    Color of horizontal lines

 ERRBAR=         Name of an input variable giving length of error
                 bar for each observation.  If not specified, no
                 error bars are drawn.

 NAME=DOTPLOT    The name assigned to the graph in the graphic
                 catalog.

 GOPTIONS required

 DOTPLOT plots each observation in a row of the graphics output
 area.  Therefore the VPOS= graphics option should specify a
 sufficient number of vertical character cells.  The value for
 VPOS= should be

      VPOS ge
       number of observations + number of groups + 8


 LOWESS macro

 The LOWESS macro performs robust, locally weighted scatterplot
 smoothing as described in Section 4.4.2.  The data and the
 smoothed curve are plotted if PLOT=YES is specified.  The
 smoothed response variable is returned in the output data set
 named by the OUT= parameter.

 Parameters

 DATA=_LAST_     Name of the input data set.

 X = X           Name of the independent (X) variable.

 Y = Y           Name of the dependent (Y) variable to be
                 smoothed.

 ID=             Name of an optional character variable to
                 identify observations.

 OUT=SMOOTH      Name of the output data set.  The output data set
                 contains the X=, Y=, and ID= variables plus the
                 variables _YHAT_, _RESID_, and _WEIGHT_.  _YHAT_
                 is the smoothed value of the Y= variable, _RESID_
                 is the residual, and _WEIGHT_ is the combined
                 weight for that observation in the final
                 iteration.


 F = .50         Lowess window width, the fraction of the
                 observtions used in each locally-weighted
                 regression.

 ITER=2          Total number of iterations.

 PLOT=NO         Draw the plot?  If you specify PLOT=YES, a high-
                 resolution plot is drawn by the macro.

 NAME=LOWESS     The name assigned to the graph in the graphic
                 catalog.

 When using the LOWESS macro with the SAS System for Personal
 Computers, it may be neccessary to add the option WORKSIZE=100 to
 the PROC IML statement.

 NQPLOT macro

 NQPLOT produces normal Q-Q plots for single variable.  The
 parameters MU= and SIGMA= determine how the comparison line,
 representing a perfect fit to a normal distribution, is
 estimated.

 Parameters

 DATA=_LAST_     Name of the input data set

 VAR=X           Name of the variable to be plotted

 OUT=NQPLOT      Name of the output data set

 MU=MEDIAN       Estimate of the of mean of the reference normal
                 distribution: Specify MU=MEAN, MU=MEDIAN, or
                 MU=<numeric value>.

 SIGMA=HSPR      Estimate of the standard deviation of the
                 reference normal distribution: Specify SIGMA=STD,
                 SIGMA=HSPR, or SIGMA=<numeric value>.

 STDERR=YES      Plot std errors around curves?

 DETREND=YES     Plot detrended version?  If DETREND=YES the
                 detrended version is plotted too.

 LH=1.5          Height, in character cells, for the axis labels.

 ANNO=           Name of an optional input Annotate data set

 NAME=NQPLOT     The name assigned to the graph(s) in the graphic
                 catalog.

 GOUT=           The name of the graphic catalog used to store the
                 graph(s) for later replay.


 OUTLIER macro

 The OUTLIER macro calculates robust Mahalanobis distances for
 each observation in a data set.  The results are robust in that
 potential outliers do not contribute to the distance of any other
 observations.  A high-resolution plot may be constructed from the
 output data set; see the examples in Section 9.3

    The macro makes one or more passes through the data.  Each
 pass assigns 0 weight to observations whose DSQ value has
 Prob ( chisquare ) < PVALUE. The number of passes should be determined
 empirically so that no new observations are trimmed on the last step.

 Parameters

 DATA=_LAST_     Name of the data set to analyze

 VAR=_NUMERIC_   List of input variables

 ID=             Name of an optional ID variable to identify
                 observations

 OUT=CHIPLOT     Name of the output data set for plotting.  The
                 robust squared distances are named DSQ.  The
                 corresponding theoretical quantiles are named
                 EXPECTED.  The variable _WEIGHT_ has the value 0
                 for observations identified as possible outliers.

 PVALUE=.1       Probability value of chi sup 2 statistic used to
                 trim observations.

 PASSES=2        Number of passes of the iterative trimming
                 procedure.

 PRINT=YES       Print the OUT= data set?


 PARTIAL macro

 The PARTIAL macro draws partial regression residual plots as
 described in Section 5.5.

 Parameters

 DATA = _LAST_   Name of the input data set.

 YVAR =          Name of the dependent variable.

 XVAR =          List of independent variables.  The list of
                 variables must be given explicitly; the range
                 notation X1-Xn cannot be used.


 ID =            Name of an optional character variable used to
                 label observations.  If ID= is not specified, the
                 observations are identified by the numbers 1, 2,
                 ...

 LABEL=INFL      Specifies which points in the plot should be
                 labelled with the value of the ID= variable.  If
                 LABEL=NONE, no points are labelled; if LABEL=ALL,
                 all points are labelled; otherwise (LABEL=INFL)
                 only potentially influential observations (those
                 with large leverage values or large studentized
                 residuals) are labelled.

 OUT =           Name of the output data set containing partial
                 residuals.  This data set contains ( p  +  1 )
                 pairs of variables, where p is the number of
                 XVAR= variables.  The partial residuals for the
                 intercept are named UINTCEPT and VINTCEPT. If
                 XVAR=X1 X2 X3, the partial residuals for X1 are
                 named UX1 and VX1, and so on.  In each pair, the
                 U variable contains the partial residuals for the
                 independent (X) variable, and the V variable
                 contains the partial residuals for the dependent
                 (Y) variable.

 GOUT=GSEG       Name of graphic catalog used to store the graphs
                 for later replay.

 NAME=PARTIAL    The name assigned to the graphs in the graphic
                 catalog.

 Computing note

 In order to follow the description in the text, the program
 computes one regression analysis for each regressor variable
 (including the intercept).  Vellman & Welsh (1981) show how the
 partial regression residuals and other regression diagnostics can
 be computed more eficiently--from the results of a single
 regression using all predictors.  They give an outline of the
 computations in the PROC MATRIX language.

 Usage Note

 When using the PARTIAL macro with the SAS System for Personal
 Computers, it may be neccessary to add the option WORKSIZE=100 to
 the PROC IML statement.

 SCATMAT macro

 The SCATMAT macro draws a scatterplot matrix for all pairs of
 variables specified in the VAR= parameter.  The program will not
 do more than 10 variables.  You could easily extend this, but the plots
 would most likely be too small to see.


    If a classification variable is specified with the GROUP=
 parameter, the value of that variable determines the shape and
 color of the plotting symbol.  The macro GENSYM defines the
 SYMBOL statements for the different groups, which are assigned
 according to the sorted value of the grouping variable.  The
 default values for the SYMBOLS= and COLORS= parameters allow for
 up to eight different plotting symbols and colors.  If no GROUP=
 variable is specified, all observations are plotted using the
 first symbol and color.

 Parameters

 DATA=_LAST_     Name of the data set to be plotted.

 VAR=            List of variables to be plotted.

 GROUP=          Name of an optional grouping variable used to
                 define the plot symbols and colors.

 SYMBOLS=%str(- + : $ = X _ Y)
                 List of symbols, separated by spaces, to use for
                 plotting points in each of the groups.  The i-th
                 element of SYMBOLS is used for group i.

 COLORS=BLACK RED GREEN BLUE BROWN YELLOW ORANGE PURPLE
                 List of colors to use for each of the groups.  If
                 there are g groups, specify g colors.  The i-th
                 element of COLORS is used for group i.

 GOUT=GSEG       Name of the graphics catalog used to store the
                 final scatterplot matrix constructed by PROC
                 GREPLAY.  The individual plots are stored in
                 WORK.GSEG.  Note that if the SCATMAT macro is
                 invoked after other graphs have been created in
                 the same SAS session, the previously created
                 graphs will be replayed into the template panels
                 instead of the plots generated in the macro.  To
                 avoid this problem, either delete existing graphs
                 from the WORK.GSEG catalog before invoking the
                 macro, or modify the macro to store the individual
                 plots in a catalog other than WORK.GSEG.

 STARS macro

 The STARS macro draws a star plot of the multivariate
 observations in a data set, as described in Section 8.4.  Each
 observation is depicted by a star-shaped figure with one ray for
 each variable, whose length is proportional to the size of that
 variable.

 Missing data

 The scaling of the data in the PROC IML step makes no allowance
 for missing values.


 Parameters

 DATA=_LAST_     Name of the data set to be displayed.

 VAR=            List of variables, in the order to be placed
                 around the star, starting from angle=0
                 (horizontal), and proceeding counterclockwise.

 ID=             Character observation identifier variable
                 (required).

 MINRAY=.1       Minimum ray length, 0<=MINRAY<1.

 ACROSS=5        Number of stars across a page.

 DOWN=6          Number of stars down a page.  If the product of
                 ACROSS and DOWN is less than the number of
                 observations, multiple graphs are produced.


 SYMPLOT macro

 The SYMPLOT macro produces any of the plots for diagnosing
 symmetry of a distribution described in Section 3.6.

 Parameters

 DATA=_LAST_     Name of the input data to be analyzed.

 VAR=            Name of the variable to be plotted.  Only one
                 variable may be specified.

 PLOT=MIDSPR     Type of plot(s): NONE, or one or more of UPLO,
                 MIDSPR, MIDZSQ, or POWER.  One plot is produced
                 for each keyword included in the PLOT= parameter.

 TRIM=0          A number or percent of extreme observations to be
                 trimmed.  If you specify TRIM=number, the highest
                 and lowest number observations are not plotted.
                 If you specify TRIM=percent  PCT,  the highest
                 and lowest percent% of the observations are not
                 plotted.  The TRIM= option is most useful in the
                 POWER plot.

 OUT=SYMPLOT     Name of the output data set

 NAME=SYMPLOT    The name assigned to the graph(s) in the graphic
                 catalog.


 TWOWAY macro

 The TWOWAY macro carries out analysis of two-way experimental
 design data with one observation per cell, including Tukey's 1
 degree of freedom test for non-additivity as described in Section
 7.6.  Two plots may be produced: a graphical display of the fit
 and residuals for the additive model, and a diagnostic plot for
 removable non-additivity.

 Parameters

 DATA=_LAST_     Name of the data set to be analyzed.  One factor
                 in the design is specified by the list of
                 variables in the VAR= parameter.  The other
                 factor is defined by the observations in the data
                 set.

 VAR=            List of variables (columns of the table) to
                 identify the levels of the first factor.

 ID=             Row identifier, a character variable to identify
                 the levels of the second factor.

 RESPONSE=Response
                 Label for the response variable on the vertical
                 axis of the two-way FIT plot.

 PLOT=FIT DIAGNOSE
                 Specifies the plots to be done.  The PLOT
                 parameter can contain one or more of the keywords
                 FIT, DIAGNOSE and PRINT.  FIT requests a high-
                 resolution plot of fitted values and residuals
                 for the additive model.  DIAGNOSE requests a
                 high-resolution diagnostic plot for removable
                 non-additivity.  PRINT produces both of these
                 plots in printed form.

 NAME=           The name assigned to the graphs in the graphic
                 catalog.

 GOUT=           Specifies the name of the graphics catalog used
                 to save the output for later replay. The default
                 is WORK.GSEG, which is erased at the end of your
                 session.  To save graphs in a permanent catalog,
                 use a two-part name.

 GOPTIONS

 You should adjust the HSIZE= and VSIZE= values on the GOPTIONS
 statement to equate the data units in the horizontal and vertical
 axes of the FIT plot so that the corners are square.
 /*-------------------------------------------------------------------*
  * BIPLOT SAS  - Macro to construct a biplot of observations and     *
  *               variables. Uses IML.                                *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  1 Mar 1989 13:16:36                                     *
  * Revised:  20 Dec 1989 09:54:19                                    *
  * Version:  1.2                                                     *
  *                                                                   *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *-------------------------------------------------------------------*/

%macro BIPLOT(
        data=_LAST_,     /* Data set for biplot                      */
        var =_NUMERIC_,  /* Variables for biplot                     */
        id  =ID,         /* Observation ID variable                  */
        dim =2,          /* Number of biplot dimensions              */
        factype=SYM,     /* Biplot factor type: GH, SYM, or JK       */
        scale=1,         /* Scale factor for variable vectors        */
        out =BIPLOT,     /* Output dataset: biplot coordinates       */
        anno=BIANNO,     /* Output dataset: annotate labels          */
        std=MEAN,        /* How to standardize columns: NONE|MEAN|STD*/
        pplot=YES);      /* Produce printer plot?                    */

%let factype=%upcase(&factype);
      %if &factype=GH  %then %let p=0;
%else %if &factype=SYM %then %let p=.5;
%else %if &factype=JK  %then %let p=1;
%else %do;
   %put BIPLOT: FACTYPE must be GH, SYM, or JK. "&factype" is not valid.;
   %goto done;
   %end;

Proc IML;
Start BIPLOT(Y,ID,VARS,OUT, power, scale);
   N = nrow(Y);
   P = ncol(Y);
   %if &std = NONE
       %then Y = Y - Y[:] %str(;);             /* remove grand mean */
       %else Y = Y - J(N,1,1)*Y[:,] %str(;);   /* remove column means */
   %if &std = STD %then %do;
      S = sqrt(Y[##,] / (N-1));
      Y = Y * diag (1 / S );
   %end;

   *-- Singular value decomposition:
        Y is expressed as U diag(Q) V prime
        Q contains singular values, in descending order;
   call svd(u,q,v,y);

   reset fw=8 noname;
   percent = 100*q##2 / q[##];
      *-- cumulate by multiplying by lower triangular matrix of 1s;
   j = nrow(q);
   tri= (1:j)`*repeat(1,1,j)  >= repeat(1,j,1)*(1:j) ;
   cum = tri*percent;
   c1={'Singular Values'};
   c2={'Percent'};
   c3={'Cum % '};
   Print "Singular values and variance accounted for",,
         q       [colname=c1 format=9.4                    ]
         percent [colname=c2 format=8.2         ]
         cum     [colname=c3 format=8.2         ];

   d = &dim ;
   *-- Extract first  d  columns of U & V, and first  d  elements of Q;
   U = U[,1:d];
   V = V[,1:d];
   Q = Q[1:d];

   *-- Scale the vectors by QL, QR;
   * Scale factor 'scale' allows expanding or contracting the variable
     vectors to plot in the same space as the observations;
   QL= diag(Q ## power );
   QR= diag(Q ## (1-power));
   A = U * QL;
   B = V * QR # scale;
   OUT=A // B;

   *-- Create observation labels;
   id = id // vars`;
   type = repeat({"OBS "},n,1) // repeat({"VAR "},p,1);
   id  = concat(type, id);

   factype = {"GH" "Symmetric" "JK"}[1 + 2#power];
   print "Biplot Factor Type", factype;

   cvar = concat(shape({"DIM"},1,d), char(1:d,1.));
   print "Biplot coordinates",
         out[rowname=id colname=cvar];
   %if &pplot = YES %then
   call pgraf(out,substr(id,5),'Dimension 1', 'Dimension 2', 'Biplot');
      ;
   create &out  from out[rowname=id colname=cvar];
   append from out[rowname=id];
finish;

   use &data;
   read all var{&var} into y[colname=vars rowname=&id];
   power = &p;
   scale = &scale;
   run biplot(y, &id,vars,out, power, scale );
   quit;

 /*----------------------------------*
  |  Split ID into _TYPE_ and _NAME_ |
  *----------------------------------*/
data &out;
   set &out;
   drop id;
   length _type_ $3 _name_ $16;
   _type_ = scan(id,1);
   _name_ = scan(id,2);
 /*--------------------------------------------------*
  | Annotate observation labels and variable vectors |
  *--------------------------------------------------*/
data &anno;
   set &out;
   length function text $8;
   xsys='2'; ysys='2';
   text = _name_;

   if _type_ = 'OBS' then do;         /* Label the observation   */
      color='BLACK';
      x = dim1; y = dim2;
      position='5';
      function='LABEL   '; output;
      end;

   if _type_ = 'VAR' then do;           /* Draw line from     */
      color='RED  ';
      x = 0; y = 0;                     /* the origin to      */
      function='MOVE'    ; output;
      x = dim1; y = dim2;               /* the variable point */
      function='DRAW'    ; output;
      if dim1 >=0
         then position='6';             /* left justify       */
         else position='2';             /* right justify      */
      function='LABEL   '; output;      /* variable name      */
      end;
%done:
%mend BIPLOT;
 /*-------------------------------------------------------------------*
  * BOXANNO SAS    Annotate a scatter plot with univariate boxplots   *
  *-------------------------------------------------------------------*
  * Author:   Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  20 Apr 1988 11:32:44                                    *
  * Revised:  17 May 1990 09:51:13                                    *
  * Version:  1.5                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *-------------------------------------------------------------------*/

 /*------------------------------------------------------------------*
  | BOXAXIS macro - create an annotate dataset to draw a boxplot for |
  |         ONE axis in a scatterplot. Can be used with Proc GPLOT   |
  |         or Proc G3D scatterplots.                                |
  |         This macro just creates the annotate dataset. It is up to|
  |         the user to call the appropriate plot procedure.         |
  |   e.g., Proc GPLOT data= ;                                       |
  |             Plot Y * X / annotate= ... ;                         |
  *------------------------------------------------------------------*/
%macro BOXAXIS(
       data=_LAST_,          /* Input dataset                     */
       out=_DATA_,           /* Output ANNOTATE dataset           */
       var=,                 /* Variable to be plotted            */
       baxis=x,              /* Axis on which it goes- X, Y, or Z */
       oaxis=y,              /* The other axis in the plot        */
       paxis=z,              /* The 3rd axis (ignored in GPLOT)   */
       boxwidth=4,           /* width of box in data percent      */
       pos=98);              /* position of box on OAXIS 0<POS<100*/

%local bx by bz;             /* macro symbols for annotate x,y,z  */
%if ( &baxis = %str() or &oaxis = %str() ) %then %do;
    %put ERROR: Box (BAXIS) and other (OAXIS) axes must be specified;
%end;
%else %do;
   %if (&baxis=&oaxis) %then %do;
       %put ERROR: BAXIS (&BAXIS) cannot be the same as OAXIS (&OAXIS);
   %end;
%end;
 /*----------------------------------*
  | Find median & quartiles          |
  *----------------------------------*/
proc univariate data=&data noprint;
    var &var;
    output out=quartile
           n=n q1=q1 q3=q3 median=median qrange=iqr mean=mean;
run;
 /*-----------------------------------------------*
  | Find outside & farout points                  |
  *-----------------------------------------------*/
data plotdat;
    set &data;
    if _n_=1 then set quartile;
    retain q1 q3 iqr;
    keep &var outside;
    outside=1;
    if &var < (q1-1.5*iqr) or &var > (q3+1.5*iqr)
       then outside=2;
    if &var < (q1-3.0*iqr) or &var > (q3+3.0*iqr)
       then outside=3;
run;
 /*----------------------------------------------------*
  |  Whiskers go from quartiles to most extreme values |
  |  which are *NOT* outside.                          |
  *----------------------------------------------------*/
data whis;
    set plotdat;
    if outside = 1;
proc univariate data=whis noprint;
    var &var;
    output out=whisk min=lo_whisk max=hi_whisk;
run;
data boxfile;
    merge quartile whisk;
proc print data=boxfile;
 /*-----------------------------------------------*
  | Annotate data set to draw boxes & whiskers    |
  *-----------------------------------------------*/
%let bx = &oaxis;
%let by = &baxis;
%let bz = &paxis;
data &out;
    set boxfile;
    drop n lo_whisk hi_whisk q1 q3 iqr median mean
         center halfwid;
    length function $8 text $8;
    halfwid= &boxwidth / 2;
%if ( &pos > 50 ) %then %do;
    center= &pos - halfwid; %end;
%else %do;
    center= &pos + halfwid; %end;
    &bx.sys = '1';         /* data percentage coordinates for 'other' */
    &by.sys = '2';         /* data value coordinates for box axis     */
%if ( &paxis ^= %str() ) %then %do;
    &bz.sys = '1';         /* data percentage coordinates for 3rd axis*/
    &bz     = 1  ;
%end;
&bx =center-halfwid       ; &by = q1;       dot=1 ; link out; * box   ;
&bx =center+halfwid       ; &by = q1;       dot=21; link out;
&bx =center+halfwid       ; &by = q3;       dot=22; link out;
&bx =center-halfwid       ; &by = q3;       dot=23; link out;
&bx =center-halfwid       ; &by = q1;       dot=24; link out; * box   ;

&bx =center-halfwid       ; &by = median  ; dot=3 ; link out; * median;
&bx =center+halfwid       ; &by = median  ; dot=4 ; link out;

&bx =center               ; &by = q1      ; dot=5 ; link out; * lo     ;
&bx =center               ; &by = lo_whisk; dot=6 ; link out; * whisker;
&bx =center               ; &by = q3      ; dot=7 ; link out; * hi     ;
&bx =center               ; &by = hi_whisk; dot=8 ; link out; * whisker;
&bx =center-halfwid/2     ; &by = lo_whisk; dot=9 ; link out;
&bx =center+halfwid/2     ; &by = lo_whisk; dot=10; link out;
&bx =center-halfwid/2     ; &by = hi_whisk; dot=11; link out;
&bx =center+halfwid/2     ; &by = hi_whisk; dot=12; link out;
&bx =center               ; &by = mean    ; dot=13; link out;
    return;

out:
   select;
      when (dot=1 | dot=3 | dot=5 | dot=7 | dot=9 | dot=11) do;
         line = .;
         function = 'MOVE';          output;
      end;
      when (dot=4 | dot=6 | dot=8 | dot=10 | dot=12
          | dot=21| dot=22| dot=23| dot=24 ) do;
         if dot=6 | dot=8
            then line = 3;
            else line = 1;
         function = 'DRAW';          output;
      end;
      when (dot = 13) do;
         text = 'STAR';
         function = 'SYMBOL';        output;
      end;
      otherwise;
   end;
   return;
run;
%mend boxaxis;

 /*---------------------------------------------------------*
  | BOXANNO macro - creates annotate dataset for both X & Y |
  *---------------------------------------------------------*/
%macro boxanno(
     data=_last_,           /* Data set to be plotted  */
     xvar=,                 /* Horizontal variable     */
     yvar=,                 /* Vertical variable       */
     out=boxanno            /* Output annotate dataset */
     );

%boxaxis(
     data=&data, var=&xvar,
     baxis=x,    oaxis=y,    out=xanno);

%boxaxis(
     data=&data, var=&yvar,
     baxis=y,    oaxis=x,    out=yanno);
 /*----------------------------------------*
  |  Concatenate the two annotate datasets |
  *----------------------------------------*/
data &out;
     set xanno yanno;
%mend boxanno;
 /*-------------------------------------------------------------------*
  * BOXPLOT SAS    SAS/Graph Box and Whisker plot                     *
  *                                                                   *
  * This SAS macro constructs and plots side-by-side Box and whisker  *
  * plots for ONE quantitative variable classified by ONE OR MORE     *
  * grouping (CLASS) variables. The CLASS variables may be character  *
  * or numeric.                                                       *
  *                                                                   *
  * The box for each group shows the location of the median, mean and *
  * quartiles. Whisker lines extend to the most extreme observations  *
  * which are no more than 1.5*IQR beyond the quartiles. Observations *
  * beyond the whiskers are plotted individually.                     *
  *                                                                   *
  * Optional NOTCHES are drawn to show approximate 95% confidence     *
  * intervals for each group median. Other options are provided to    *
  * connect group medians, draw box widths proportional to sample     *
  * size, and allow formatted labels for both variables.              *
  * References:                                                       *
  *   Olmstead, A. "Box Plots using SAS/Graph Software", SAS SUGI,    *
  *     1985, 888-894.                                                *
  *   McGill, R., Tukey, J.W., & Larsen, W. "Variations of Box Plots",*
  *     American Statistician, 1978, 32, 12-16.                       *
  *-------------------------------------------------------------------*
  * Author:   Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  12 Apr 1988 10:19:15                                    *
  * Revised:  12 Oct 1990 09:25:10                                    *
  * Version:  1.3                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *-------------------------------------------------------------------*/
                               /* Description of Parameters:         */
%macro BOXPLOT(                /* -------------------------          */
       data=_LAST_,            /* Input dataset                      */
       class=,                 /* Grouping variable(s)               */
       var=,                   /* Ordinate variable                  */
       id=,                    /* Observation ID variable            */
       width=.5,               /* Box width as proportion of maximum */
       notch=0,                /* =0|1, 1=draw notched boxes         */
       connect=0,              /* =0 or line style to connect medians*/
       f=0.5,                  /* Notch depth, fraction of halfwidth */
       fn=1,                   /* Box width proportional to &FN      */
       varfmt=,                /* Format for ordinate variable       */
       classfmt=,              /* Format for class variable(s)       */
       varlab=,                /* Label for ordinate variable        */
       classlab=,              /* Label for class variable(s)        */
       yorder=,                /* Tick marks, range for ordinate     */
       anno=,                  /* Addition to ANNOTATE set           */
       out=boxstat,            /* Output data set: quartiles, etc.   */
       name=BOXPLOT            /* Name for graphic catalog entry     */
       );

options nonotes;
%let _DSN_ = %upcase(&DATA);
%if &classlab = %str() %then %let classlab = &class;
%let CLASS = %upcase(&CLASS);
proc sort data=&DATA;
    by &CLASS;
run;
%let clvars = %nvar(&class);

 /*----------------------------------------*
  | Determine if &CLASS is char or numeric |
  *----------------------------------------*/
%let cltype=;
proc contents data=&DATA out=work noprint;
data _NULL_;
     length label2 $40;
     set work;
     if name="&CLASS"
        then if type=1 then call symput('CLTYPE', 'NUM');
                       else call symput('CLTYPE', 'CHAR');

     *-- find length of variable label and set y label angle --;
     %if &varlab ^= %str() %then
        %str( label2 = "&varlab"; );
     %else
        %str( if name="&VAR" then label2=label; );
     if length(label2) <=8
        then call symput('YANGLE','');
        else call symput('YANGLE','a=90 r=0');
run;              /* Run required here */

 /*----------------------------------------------------------------*
  |  If there are more than one class variables or class variable  |
  |  is CHAR, create a numeric class variable, XCLASS. XCLASS      |
  |  numbers the groups from 1,...number-of-groups. It is up to    |
  |  the user to supply a format to associate proper group labels  |
  |  with the XCLASS value.                                        |
  *----------------------------------------------------------------*/
%if ( &cltype=CHAR or &clvars > 1 ) %then %do;
   %let lclass = %scan( &CLASS, &clvars );
   data work;
      set &DATA;
      by &CLASS;
      if (first.&LCLASS) then xclass + 1;
      %if &cltype=CHAR and &clvars=1 and &classfmt=%str() %then
         %do;
         call symput('val'||left(put( xclass, 2. )), trim(&class) );
         %end;

   run;
   %let KLASS = xclass;
   %let data  = work;
   run;
%end;
%else %let KLASS = &CLASS;

 /*------------------------------------------------*
  | Determine number of groups & quartiles of each |
  *------------------------------------------------*/
proc means noprint data=&data;
    var &KLASS;
    output out=_grsum_ min=grmin max=grmax ;
    run;
proc univariate data=&data noprint;
    by &KLASS;
    var &VAR;
    output out=_qtile_
           n=n q1=q1  q3=q3  median=median qrange=iqr mean=mean;
data _qtile_;
    set _qtile_;
    By  &KLASS;
    Lo_Notch = Median - 1.58*IQR / sqrt(N);
    Hi_Notch = Median + 1.58*IQR / sqrt(N);
run;
data merged;
    merge &DATA _qtile_;
    by &KLASS;
 /*-----------------------------------------------*
  | Find outside & farout points                  |
  *-----------------------------------------------*/
data plotdat;
    set merged;
    keep &KLASS &VAR &ID outside;
    if &VAR ^= .;
    outside=1;
    if &VAR < (Q1 -1.5*IQR) or &VAR > (Q3 +1.5*IQR)
       then outside=2;
    if &VAR < (Q1 -3.0*IQR) or &VAR > (Q3 +3.0*IQR)
       then outside=3;
run;
data _out_;
   set plotdat;
   if outside > 1 ;
proc sort data=_out_;
   by &KLASS &VAR ;
proc print data=_out_;
   id &ID &KLASS;
   title3 "Outside Observations in Data Set &_DSN_ ";
run;
 /*-----------------------------------------------------*
  |  If connnecting group medians, find them and append |
  *-----------------------------------------------------*/
%if ( &connect ) %then %do;
   data connect;
      set _qtile_(keep=&KLASS Median
                    rename=(Median=&VAR));
      outside=0;
   proc append base=plotdat
               data=connect;
   run;
%end;

 /*----------------------------------------------------*
  |  Whiskers go from quartiles to most extreme values |
  |  which are *NOT* outside.                          |
  *----------------------------------------------------*/
data _in_;
   set plotdat;
   if outside = 1;            /* select inside points */
proc univariate data=_in_ noprint;
   by &KLASS;
   var &VAR;                  /* find min and max     */
   output out=_whisk_ min=lo_whisk max=hi_whisk;
run;
data &out;
    merge _qtile_ _whisk_ end=lastobs;
    by &KLASS;
    retain halfmax 1e23 fnmax -1e23;
    drop span halfmax fnmax offset grps;

    span = dif ( &KLASS );            /* x(k+1) - x(k) */
    if (_n_ > 1 )
       then halfmax = min( halfmax, span/2);
    fnmax = max( fnmax, &FN );

   if ( lastobs ) then do;
      if _n_=1 then halfmax=.5;
      call symput ('HALFMAX', left(put(halfmax,best.)) );
      put ' Maximum possible halfwidth is: ' halfmax /;
      call symput ('FNMAX',  left(put(fnmax,best.)) );
      grps=_n_;
      offset=max(5, 35-5*grps);
      call symput('OFFSET',left(put(offset,2.)) );
      put ' Number of groups: ' grps  'offset=' offset ;
   end;

proc print ;
   id &KLASS;
   title3 'BOXPLOT: Quartiles, notches and whisker values';
run;
 /*-----------------------------------------------*
  | Annotate data set to draw boxes & whiskers    |
  *-----------------------------------------------*/
data _dots_;
    set &out;
    retain halfmax &HALFMAX  k ;
    drop k halfmax halfwid hi_notch lo_notch iqr median mean q1  q3 ;
    drop grmin grmax ;
    if ( _n_ = 1) then do;
       set _grsum_;
       K = &WIDTH * HalfMax;
    end;
    halfwid = K * &FN / &FNMax ;
    length function text $8;
    XSYS = '2'; YSYS = '2';

   /*    Produce connect-the-dots X, Y pairs */
   X = &KLASS                      ; Y= Lo_Whisk ; dot =  1; link out;
   X = &KLASS                      ; Y= Q1       ; dot =  2; link out;
   X = &KLASS - halfwid            ; Y= Q1       ; dot =  3; link out;

%if ( &notch ) %then %do;
   X = &KLASS - halfwid            ; Y= Lo_Notch ; dot =  4; link out;
   X = &KLASS - (1-&F)*halfwid     ; Y= Median   ; dot =  5; link out;
   X = &KLASS - halfwid            ; Y= Hi_Notch ; dot =  6; link out;
%end;
   X = &KLASS - halfwid            ; Y= Q3       ; dot =  7; link out;
   X = &KLASS                      ; Y= Q3       ; dot =  8; link out;
   X = &KLASS                      ; Y= Hi_Whisk ; dot =  9; link out;
   X = &KLASS                      ; Y= Q3       ; dot = 10; link out;
   X = &KLASS + halfwid            ; Y= Q3       ; dot = 11; link out;
%if ( &notch ) %then %do;
   X = &KLASS + halfwid            ; Y= Hi_Notch ; dot = 12; link out;
%end;
   X = &KLASS+(1-&NOTCH*&F)*halfwid; Y= Median   ; dot = 13; link out;
   X = &KLASS-(1-&NOTCH*&F)*halfwid; Y= Median   ; dot = 14; link out;
   X = &KLASS+(1-&NOTCH*&F)*halfwid; Y= Median   ; dot = 15; link out;
%if ( &notch ) %then %do;
   X = &KLASS + halfwid            ; Y= Lo_Notch ; dot = 16; link out;
%end;
   X = &KLASS + halfwid            ; Y= Q1       ; dot = 17; link out;
   X = &KLASS                      ; Y= Q1       ; dot = 18; link out;

   X = &KLASS - halfwid/3          ; Y= Lo_Whisk ; dot = 19; link out;
   X = &KLASS - halfwid/3          ; Y= Hi_Whisk ; dot = 19; link out;
   X = &KLASS                      ; Y= Mean     ; dot = 20; link out;
   return;

out:
    Select;
       when ( dot=1 ) do;
          FUNCTION = 'MOVE';                   output;
          FUNCTION = 'POLY';                   output;
          End;
       when ( 1< dot <=18) do;
          FUNCTION = 'POLYCONT';               output;
          End;
       when ( dot=19) do;
          FUNCTION = 'MOVE';                   output;
          X = X + 2*halfwid/3 ;
          FUNCTION = 'DRAW';                   output;
          End;
       when ( dot=20) do;
          FUNCTION = 'MOVE';                   output;
          FUNCTION = 'SYMBOL'; TEXT='STAR';    output;
          End;
          Otherwise ;
    End;
    Return;
run;

 /*-----------------------------------------------------*
  |  Annotate data set to plot and label outside points |
  *-----------------------------------------------------*/
data _label_;
   set _out_;                          /* contains outliers only */
   by &KLASS;
   keep xsys ysys x y function text style position;
   length text function style $8;
   xsys = '2'; ysys = '2';
   y = &VAR;
   x = &KLASS ;
   function = 'SYMBOL';                     /* draw the point   */
   style = ' ';
   position = ' ';
   if OUTSIDE=2
      then do;  text='DIAMOND'; size=1.7; end;
      else do;  text='SQUARE '; size=2.3; end;
   output;
   %if &ID ^= %str() %then %do;            /* if ID variable,   */
      if first.&KLASS then out=0;
      out+1;
      function = 'LABEL';                  /*  .. then label it */
      text = &ID;
      size=.9;
      style='SIMPLEX';
      x = &KLASS;
      if mod(out,2)=1                      /* on alternating sides*/
         then do; x=x -.05; position='4';  end;
         else do; x=x +.05; position='6';  end;
      output;
   %end;
data _dots_;
   set _dots_ _label_ &anno ;
 /*------------------------------------*
  | Clean up datasets no longer needed |
  *------------------------------------*/
proc datasets nofs nolist library=work memtype=(data);
    delete work _grsum_ merged _in_ _whisk_ _qtile_ _label_;
options notes;
 /*--------------------------------------*
  | Symbols for connecting group medians |
  *--------------------------------------*/
%if &connect ^= 0  %then %do;
  symbol1 C=BLACK V=NONE I=JOIN L=&connect r=1; /* connected medians   */
  symbol2 C=BLACK V=NONE R=3;                 /* rest done by annotate */
%end;
%else %do;
  symbol1 C=BLACK V=NONE R=3 i=none;          /* all done by annotate  */
%end;
title3;

proc gplot data=plotdat ;
  plot &VAR * &KLASS = outside
       / frame nolegend name="&name"
         vaxis=axis1 haxis=axis2 hminor=0
         annotate=_dots_;
  %if %length(&yorder) > 0 %then
     %let yorder = order=(&yorder);
  axis1
       &yorder
       value=(h=1.2) label =(&yangle h=1.5);
  axis2 value=(h=1.2) label =(h=1.5) offset=(&offset pct);
  %if &varfmt ^=  %str() %then %do; format &var   &varfmt ;      %end;
  %if &classfmt^= %str() %then %do; format &KLASS &classfmt ;    %end;
  %if &varlab ^=  %str() %then %do; label  &var   = "&varlab";   %end;
  %if &classlab^= %str() %then %do; label  &KLASS = "&classlab"; %end;
run;
%mend boxplot;

 /*----------------------------------*
  | Count number of &CLASS variables |
  *----------------------------------*/
%macro nvar(varlist);
   %local wvar result;
   %let result = 1;
   %let wvar = %nrbquote(%scan( &varlist, &result));
   %do %until ( &wvar= );
       %let result = %eval( &result + 1);
       %let wvar = %nrbquote(%scan( &varlist, &result));
   %end;
   %eval( &result - 1)
%mend nvar;
 /*-------------------------------------------------------------------*
  *    Name: CONTOUR SAS                                              *
  *   Title: IML macro to plot elliptical contours for X, Y data      *
  *     Ref: IML User's Guide, version 5 Edition                      *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  8 Jun 1988 12:33:21                                     *
  * Revised:  10 May 1990 11:15:56                                    *
  * Version:  2.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/

%macro CONTOUR(
       data=_LAST_,           /* input data set                   */
       x=,                    /* X variable                       */
       y=,                    /* Y variable                       */
       group=,                /* Group variable (optional)        */
       pvalue= .5,            /* Confidence coefficient (1-alpha) */
       std=STDERR,            /* error bar metric: STD or STDERR  */
       points=40,             /* points on each contour           */
       all=NO,                /* include contour for total sample?*/
       out=CONTOUR,           /* output data set                  */
       plot=YES,              /* plot the results?                */
       i=none,                /* SYMBOL statement interpolate opt */
       name=CONTOUR,          /* Name for graphic catalog entry   */
       colors=RED GREEN BLUE BLACK PURPLE YELLOW BROWN ORANGE,
       symbols=+ square star -     plus   :      $     = );

%let all = %upcase(&all);
%if &x=%str() or &y=%str() %then %do;
   %put CONTOUR: X= and Y= variables must be specified;
   %goto DONE;
   %end;

proc iml;
start ellipse(c, x, y, npoints, pvalues, formean);
  /*----------------------------------------------------------------*
   |  Computes elliptical contours for a scatterplot                |
   |   C       returns the contours as consecutive pairs of columns |
   |   X,Y     coordinates of the points                            |
   |   NPOINTS scalar giving number of points around a contour      |
   |   PVALUES column vector of confidence coefficients             |
   |   FORMEAN 0=contours for observations, 1=contours for means    |
   *----------------------------------------------------------------*/

   xx = x||y;
   n  = nrow(x);
   *-- Correct for the mean --;
   mean = xx[+,]/n;
   xx = xx - mean @ j(n,1,1);

   *-- Find principal axes of ellipses --;
   xx = xx` * xx / (n-1);
   print 'Variance-Covariance Matrix',xx;
   call eigen(v, e, xx);

   *-- Set contour levels --;
   c =  2*finv(pvalues,2,n-1,0);
   if formean=1 then c = c / (n-1) ;
   print 'Contour values',pvalues c;
   a = sqrt(c*v[ 1 ] );
   b = sqrt(c*v[ 2 ] );

   *-- Parameterize the ellipse by angles around unit circle --;
   t = ( (1:npoints) - {1}) # atan(1)#8/(npoints-1);
   s = sin(t);
   t = cos(t);
   s = s` * a;
   t = t` * b;

   *-- Form contour points --;
   s = ( ( e*(shape(s,1)//shape(t,1) )) +
         mean` @ j(1,npoints*ncol(c),1) )` ;
   c = shape( s, npoints);
   *-- C returned as NCOL pairs of columns for contours--;
finish;

start dogroups(x, y, gp, pvalue);
   d  = design(gp);
   %if &all=YES %then %do;
      d = d || j(nrow(x),1,1);
   %end;
   do group = 1 to ncol(d);
      Print group;
      *-- select observations in each group;
      col = d[, group ];
      xg  = x[ loc(col), ];
      yg  = y[ loc(col), ];
      *-- Find ellipse boundary ;
      run ellipse(xyg,xg,yg,&points, pvalue, 0 );
      nr = nrow(xyg);

      *-- Output contour data for this group;
      cnames = { X Y PVALUE GP };
      do c=1 to ncol(pvalue);
         col=(2*c)-1 : 2*c ;
         xygp = xyg[,col] || j(nr,1,pvalue[c]) || j(nr,1,group);
         if group=1 & c=1
            then create contour from xygp [colname=cnames];
         append from xygp;
      end;
   end;
finish;

*-- Get input data: X, Y, GP;
   use &data;
   read all var {&x}     into x [colname=lx];
   read all var {&y}     into y [colname=ly];
%if &group ^= %str() %then %do;
   read all var {&group} into gp [colname=lg] ;
   %end;
%else %do;
   gp = j(nrow(x),1,1);
   %end;
   close &data;

*-- Find contours for each group;
   run dogroups(x, y, gp, { &pvalue} );


 /*-----------------------------------*
  |  Plot the contours using ANNOTATE |
  *-----------------------------------*/
data contour;
   set contour ;
   by gp pvalue notsorted;
   length function color $8;
   xsys='2'; ysys='2';
   if first.pvalue then function='POLY';
                   else function='POLYCONT';
   color=scan("&colors",gp);
   line = 5;
run;
 /*----------------------------*
  |  Crosses at Mean +- StdErr |
  *----------------------------*/
proc summary data=&data nway;
   class &group;
   var &x &y;
   output out=sumry mean=mx my &std=sx sy;
proc print;
data bars;
   set sumry end=eof;
   %if &group ^= %str() %then %str(by &group;);
   length function color $8;
   retain g 0;
   drop _freq_ _type_ mx my sx sy g;
   xsys='2'; ysys='2';

   %if &group ^= %str() %then %do;
      if first.&group then g+1;
   %end;
   color=scan("&colors",g);
   line=3;
   x = mx-sx; y=my;      function='MOVE'; output;
   x = mx+sx;            function='DRAW'; output;
   x = mx   ; y=my-sy;   function='MOVE'; output;
              y=my+sy;   function='DRAW'; output;

 *-- Write group label (convert numeric &group to character);
   %if &group ^= %str() %then %do;
      length text $16;
      text = left(&group);
      position='3';
      size = 1.4;
      x = mx+.2*sx   ; y=my+.2*sy;
      function='LABEL'; output;
   %end;
   if eof then call symput('NGROUP',put(g,best.));
run;

data &out;
   set contour bars;

%if &group = %str() %then %let group=1;
%if %upcase(&plot)=YES %then %do;
   %gensym(n=&ngroup, h=1.2, i=&i, colors=&colors, symbols=&symbols );
   proc gplot data=&data ;
      plot &y * &x = &group /
           annotate=&out
           nolegend frame
           vaxis=axis1 vminor=0
           haxis=axis2 hminor=0
           name="&name";
      axis1 offset=(3) value=(h=1.5) label=(h=1.5 a=90 r=0);
      axis2 offset=(3) value=(h=1.5) label=(h=1.5);
run;
%end;
%done: ;
%mend contour;

 /*----------------------------------------------------*
  |  Macro to generate SYMBOL statement for each GROUP |
  *----------------------------------------------------*/
%macro gensym(n=1, h=1.5, i=none,
              symbols=%str(- + : $ = X _ Y),
              colors=BLACK RED GREEN BLUE BROWN YELLOW ORANGE PURPLE);
    %*-- note: only 8 symbols & colors are defined;
    %*--    revise if more than 8 groups (recycle);
  %local chr col k;
  %do k=1 %to &n ;
     %let chr =%scan(&symbols, &k,' ');
     %let col =%scan(&colors, &k, ' ');
     symbol&k h=&h v=&chr c=&col i=&i;
  %end;
%mend gensym;
 /*-------------------------------------------------------------------*
  * CORRESP SAS     Correspondence analysis of contingency tables     *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  19 Jan 1990 15:23:09                                    *
  * Revised:  27 Jun 1991 11:48:09                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro CORRESP(
     data=_LAST_,        /* Name of input data set               */
     var=,               /* Column variables                     */
     id=,                /* ID variable: row labels              */
     out=COORD,          /* output data set for coordinates      */
     anno=LABEL,         /* name of annotate data set for labels */
     rowht=1,            /* height for row labels                */
     colht=1             /* height for col labels                */
     );
 /*------------------------------------------*
  |  IML routine for Correspondence Analysis |
  *------------------------------------------*/
Proc IML;
Start CORRESP(F,RowId,Vars);
   I = nrow(F);
   J = ncol(F);
   R = F[,+];                   * Row totals;
   C = F[+,];                   * Col totals;
   N = F[+];                    * Grand total;
   E  = R * C / N;              * Expected frequencies;
   D = (F - E) / sqrt(E);       * Standardized deviates;
   D = D / sqrt( N );
   DPD = D` * D;
   Inertia = trace(DPD);
   Chisq = N * Inertia;         * Total chi-square;
   DF = (I-1)*(J-1);
   reset noname;
   Print 'Overall Association', CHISQ[colname={'ChiSq'}]
                                DF[colname={DF} format=6.0];

   call eigen(values, vectors, dpd);
   k = min(I,J)-1;                * number of non-zero eigenvalues;
   values  = values[1:k];
   cancorr = sqrt(values);        * singular values = Can R;
   chisq = n * values ;           * contribution to chi-square;
   percent = 100* values / inertia;
      *-- Cumulate by multiplying by lower triangular matrix of 1s;
   tri= (1:k)`*repeat(1,1,k)  >= repeat(1,k,1)*(1:k) ;
   cum = tri*percent;
   print 'Singular values, Inertia, and Chi-Square Decomposition',,
         cancorr [colname={' Singular   Values'} format=9.4]
         values  [colname={'Principal Inertias'} format=9.4]
         chisq   [colname={'  Chi-     Squares'} format=9.3]
         percent [colname={'Percent'} format=8.2]
         cum     [colname={'Cum %  '} format=8.2];

   L = values[1:2];
   U = vectors[,1:2];
   Y = diag(1/sqrt(C/N)) * U * diag(sqrt(L));
   X = diag(N/R) * (F / N) * Y * diag(sqrt(1/L));
   Print 'Row Coordinates'   , X [Rowname=RowId Colname={DIM1 DIM2}];
   Print 'Column Coordinates', Y [Rowname=Vars  Colname={DIM1 DIM2}];

   OUT = X // Y;
   ID  = RowId // Vars`;
*  Call PGRAF(OUT,ID,'Dimension 1', 'Dimension 2', 'Row/Col Association');
   TYPE = repeat({"OBS "},I,1) // repeat({"VAR "},J,1);
   ID  = concat(TYPE, ID);
   Create &out  from OUT[rowname=ID colname={"Dim1" "Dim2"}];
   Append from OUT[rowname=ID];
Finish;

Use &data;
Read all VAR {&var} into F [Rowname=&id Colname=Vars];

Run CORRESP(F,&id,Vars);
quit;
 /*----------------------------------*
  |  Split ID into _TYPE_ and _NAME_ |
  *----------------------------------*/
data &out;
   set &out;
   drop id;
   length _type_ $3 _name_ $16;
   _type_ = scan(id,1);
   _name_ = scan(id,2);
proc print data=&out;
   id _type_ _name_;
 /*--------------------------------------------------*
  | Annotate row and column labels                   |
  *--------------------------------------------------*/
data &anno;
   set &out;
   length function $8 text $16;
   xsys='2'; ysys='2';
   text = _name_;
   style='DUPLEX';
   x = dim1; y = dim2;

   if _type_ = 'OBS' then do;
      size= &rowht ;
      color='BLACK';
      position='5';
      function='LABEL   '; output;
      end;

   if _type_ = 'VAR' then do;
      color='RED  ';
      size= &colht;
      if dim1 >=0
         then position='6';             /* left justify       */
         else position='4';             /* right justify      */
      function='LABEL   '; output;
      end;
%mend CORRESP;
 /*-------------------------------------------------------------------*
  * CORRESP2 SAS    Correspondence analysis of contingency tables     *
  *         **** USE WITH VERSION 6 ONLY ****                         *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  19 Jan 1990 15:23:09                                    *
  * Revised:  27 Jun 1991 11:48:09                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro CORRESP(
     data=_LAST_,        /* Name of input data set               */
     var=,               /* Column variables                     */
     id=,                /* ID variable: row labels              */
     out=COORD,          /* output data set for coordinates      */
     anno=LABEL,         /* name of annotate data set for labels */
     rowht=1,            /* height for row labels                */
     colht=1             /* height for col labels                */
     );
 /*------------------------------------------*
  |  IML routine for Correspondence Analysis |
  *------------------------------------------*/
Proc IML;
Start CORRESP(F,RowId,Vars);
   I = nrow(F);
   J = ncol(F);
   R = F[,+];                   * Row totals;
   C = F[+,];                   * Col totals;
   N = F[+];                    * Grand total;
   E  = R * C / N;              * Expected frequencies;
   D = (F - E) / sqrt(E);       * Standardized deviates;
   D = D / sqrt( N );
   DPD = T(D) * D;
   Inertia = trace(DPD);
   Chisq = N * Inertia;         * Total chi-square;
   DF = (I-1)*(J-1);
   reset noname;
   C1={"ChiSq"};
   C2={"DF"};
   Print 'Overall Association', CHISQ[colname=C1]
                                DF[colname=C2 format=6.0];

   call eigen(values, vectors, dpd);
   k = min(I,J)-1;                * number of non-zero eigenvalues;
   values  = values[1:k];
   cancorr = sqrt(values);        * singular values = Can R;
   chisq = n * values ;           * contribution to chi-square;
   percent = 100* values / inertia;
      *-- Cumulate by multiplying by lower triangular matrix of 1s;
   tri= T(1:k)*repeat(1,1,k)  >= repeat(1,k,1)*(1:k) ;
   cum = tri*percent;
   C1={'Singular Values'};
   C2={'Inertias'};
   C3={'Chi-Squares'};
   C4={'Percent'};
   C5={' Cum % '};
   print 'Singular values, Inertia, and Chi-Square Decomposition',,
         cancorr [colname=C1 format=9.4]
         values  [colname=C2 format=9.4]
         chisq   [colname=C3 format=9.3]
         percent [colname=C4 format=8.2]
         cum     [colname=C5 format=8.2];

   L = values[1:2];
   U = vectors[,1:2];
   Y = diag(1/sqrt(C/N)) * U * diag(sqrt(L));
   X = diag(N/R) * (F / N) * Y * diag(sqrt(1/L));
   D2={'DIM1' 'DIM2'};
   Print 'Row Coordinates'   , X [Rowname=RowId Colname=D2];
   Print 'Column Coordinates', Y [Rowname=Vars  Colname=D2];
   OUT = X // Y;
   ID  = RowId // T(Vars);
*  Call PGRAF(OUT,ID,'Dimension 1', 'Dimension 2', 'Row/Col Association');
   TYPE = repeat({"OBS "},I,1) // repeat({"VAR "},J,1);
   ID  = concat(TYPE, ID);
   Create &out  from OUT[rowname=ID colname={"Dim1" "Dim2"}];
   Append from OUT[rowname=ID];
Finish;

Use &data;
Read all VAR {&var} into F [Rowname=&id Colname=Vars];

Run CORRESP(F,&id,Vars);
quit;
 /*----------------------------------*
  |  Split ID into _TYPE_ and _NAME_ |
  *----------------------------------*/
data &out;
   set &out;
   drop id;
   length _type_ $3 _name_ $16;
   _type_ = substr(id,1,3);
   _name_ = substr(id,5);
proc print data=&out;
   id _type_ _name_;
 /*--------------------------------------------------*
  | Annotate row and column labels                   |
  *--------------------------------------------------*/
data &anno;
   set &out;
   length function $8 text $16;
   xsys='2'; ysys='2';
   text = _name_;
   style='DUPLEX';
   x = dim1; y = dim2;

   if _type_ = 'OBS' then do;
      size= &rowht ;
      color='BLACK';
      position='5';
      function='LABEL   '; output;
      end;

   if _type_ = 'VAR' then do;
      color='RED  ';
      size= &colht;
      if dim1 >=0
         then position='6';             /* left justify       */
         else position='4';             /* right justify      */
      function='LABEL   '; output;
      end;
%mend CORRESP;
 /*-------------------------------------------------------------------*
  * DENSITY SAS    Nonparametric density estimates from a sample.     *
  *                                                                   *
  * User chooses a bandwidth parameter to balance smoothness and bias *
  * and the range of the data over which the density is to be fit.    *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  23 Mar 1989 16:21:12                                    *
  * Revised:  11 Jun 1991 12:05:09                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*
  *      Original program by: C. ROGER LONGBOTHAM                     *
  *      while at Rockwell International, Rocky Flats Plant           *
  * From: SAS SUGI 12, 1987, 907-909.                                 *
  *-------------------------------------------------------------------*/

%macro DENSITY(
     data=_LAST_,        /* Name of input data set              */
     out=DENSPLOT,       /* Name of output data set             */
     var=X,              /* Input variable (numeric)            */
     window=,            /* Bandwidth (H)                       */
     xfirst=.,           /* . or any real; smallest X value     */
     xlast=.,            /* . or any real; largest X value      */
     xinc=. );           /* . or value>0; X-value increment     */
                         /* Default: (XLAST-XFIRST)/60          */
data _in_;
   set &data;
   keep &var;
   if &var ^= .;
proc sort data=_in_;
   by &var;

proc iml;

start WINDOW;    *-- Calculate default window width;
   mean = xa[+,]/n;
   css = ssq(xa - mean);
   stddev = sqrt(css/(n-1));
   q1 = floor(((n+3)/4) || ((n+6)/4));
   q1 = (xa[q1,]) [+,]/2;
   q3 = ceil(((3*n+1)/4) || ((3*n-2)/4));
   q3 = (xa[q3,]) [+,]/2;
   quartsig = (q3 - q1)/1.349;
   h  = .9*min(stddev,quartsig) * n##(-.2);  * Silvermans formula;
   finish;

start INITIAL;   *-- Translate parameter options;
   if xf=. then xf=xa[1,1];
   if xl=. then xl=xa[n,1];
   if xl <= xf then do;
      print 'Either largest X value chosen is too small';
      print 'or all data values are the same';
      stop;
      end;
   if dx=. | dx <= 0 then do;
      inc = (xl-xf)/60;
      rinc = 10 ## (floor(log10(inc))-1);
      dx = round(inc,rinc);
      end;
   if xf=xa[1,1] then xf=xf-dx;
   nx = int((xl-xf)/dx) +  3;
   finish;

*-- calculate density at specified x values;
start DENSITY;
   fnx = j(nx,3,0);
   vars = {"DENSITY"  "&VAR" "WINDOW"};
   create &out from fnx [colname=vars];
   sigmasqr = .32653;                   * scale constant for kernel  ;
   gconst = sqrt(2*3.14159*sigmasqr);
   nuh = n*h;
   x = xf - dx;
   do i = 1 to nx;
      x = x + dx;
      y = (j(n,1,x) - xa)/h;
      ky = exp(-.5*y#y / sigmasqr) / gconst;      * Gaussian kernel;
      fnx[i,1] = sum(ky)/(nuh);
      fnx[i,2] = x;
      end;
   fnx[,3] = round(h,.001);
   append from fnx;
   finish;

*-- Main routine ;
   use _in_;
   read all var "&var" into xa [colname=invar];
   n = nrow(xa);
   %if &window=%str() %then %do;
      run window;
      %end;
   %else %do;
      h = &window ;
      %end;

   xf    = &xfirst;
   xl    = &xlast;
   dx    = &xinc;
   run initial;
   run density;
   close &out;
   quit;
%mend DENSITY;
 /*-------------------------------------------------------------------*
  * DOTPLOT SAS    Macro for dot charts                               *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  14 May 1989 09:12:26                                    *
  * Revised:  25 Sep 1991 16:39:06                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro dotplot(
       data=_LAST_,          /* input data set                         */
       xvar=,                /* horizontal variable (response)         */
       xorder=,              /* plotting range of response             */
       xref=,                /* reference lines for response variable  */
       yvar=,                /* vertical variable (observation label)  */
       ysortby=&xvar,        /* how to sort observations               */
       ylabel=,              /* label for y variable                   */
       group=,               /* vertical grouping variable             */
       gpfmt=,               /* format for printing group variable     */
                             /* value (include the . at the end)       */
       connect=DOT,          /* draw lines to ZERO, DOT, AXIS, or NONE */
       dline=2,              /* style of horizontal lines              */
       dcolor=BLACK,         /* color of horizontal lines              */
       errbar=,              /* variable giving length of error bar    */
                             /* for each observation                   */
       name=DOTPLOT);        /* Name for graphic catalog entry         */

%if &yvar= %str() %then %do;
   %put DOTPLOT: Must specify y variable;
   %goto ENDDOT;
   %end;
%let connect=%upcase(&connect);
%if &ylabel = %str() %then %let ylabel=%upcase(&yvar);
%global nobs vref;
 /*--------------------------------------------------*
  | Sort observations in the desired order on Y axis |
  *--------------------------------------------------*/
%if &group ^= %str() OR &ysortby ^= %str() %then %do;
proc sort data=&data;
   by &group &ysortby;
%end;

 /*-----------------------------------------------------*
  | Add Sort_Key variable and construct macro variables |
  *-----------------------------------------------------*/
data _dot_dat;
  set &data;
  %if &group = %str() %then %do;
     %let group= _GROUP_;
     _group_ = 1;
  %end;
run;

data _dot_dat;
  set _dot_dat end=eof;
  retain vref ; drop vref;
  length vref $60;
     by &group;
  sort_key + 1;
  call symput( 'val' || left(put( sort_key, 3. )), trim(&yvar) );
  output;     /* output here so sort_key is in sync */

  if _n_=1 then vref='';
  if last.&group & ^eof then do;
     sort_key+1;
     vref = trim(vref) || put(sort_key, 5.);
     call symput('val'|| left(put(sort_key, 3.)), '  ' );
     end;
  if eof then do;
     call symput('nobs', put(sort_key, 4.));
     call symput('vref', trim(vref));
     end;
run;

%if &nobs=0 %then %do;
   %put DOTPLOT: Data set &data has no observations;
   %goto ENDDOT;
   %end;
%makefmt(&nobs);

 /*---------------------------------------------------*
  | Annotate data set to draw horizontal dotted lines |
  *---------------------------------------------------*/
data _dots_;
   set _dot_dat;
      by &group;
   length function $ 8 text $ 20;
   text = ' ';
   %if &connect = ZERO
       %then %str(xsys = '2';) ;
       %else %str(xsys = '1';) ;
   ysys = '2';
   line = &dline;
   color = "&dcolor";
   y  = sort_key;
   x = 0;
   function ='MOVE'; output;

   function ='DRAW';
   %if &connect = DOT | &connect = ZERO
       %then %do;
          xsys = '2';
          x = &xvar; output;
       %end;
       %else %if &connect = AXIS
          %then %do;
          function='POINT';
          do x = 0 to 100 by 2;
             output;
             end;
          %end;

   %if &group ^= _GROUP_ %then %do;
      if first.&group then do;
         xsys = '1';
         x = 98; size=1.5;
         function = 'LABEL';
         color='BLACK';
         position = 'A';
         %if &gpfmt ^= %str()
            %then %str(text = put(&group, &gpfmt ) ;) ;
            %else %str(text = &group ;) ;
         output;
      end;
   %end;

%if &errbar ^= %str() %then %do;
data _err_;
   set _dot_dat;
   xsys = '2'; ysys = '2';
   y = sort_key;
   x = &xvar - &errbar ;
   function = 'MOVE ';   output;
   text = '|';
   function = 'LABEL';   output;
   x = &xvar + &errbar ;
   function = 'DRAW ';   output;
   function = 'LABEL';   output;
data _dots_;
   set _dots_ _err_;
%end;
 /*-----------------------------------------------*
  | Draw the dot plot, plotting formatted Y vs. X |
  *-----------------------------------------------*/
proc gplot data= _dot_dat ;
   plot sort_key * &xvar
        /vaxis=axis1 vminor=0
         haxis=axis2 frame
         name="&name"
     %if &vref ^= %str()
     %then    vref=&vref ;
     %if &xref ^= %str()
     %then    href=&xref lhref=21 chref=red ;
         annotate=_dots_;
   label   sort_key="&ylabel";
   format  sort_key _yname_.;
   symbol1 v='-' h=1.4 c=black;
   axis1   order=(1 to &nobs by 1)   label=(f=duplex)
           major=none value=(j=r f=simplex);
   axis2   %if %length(&xorder)>0 %then order=(&xorder) ;
           label=(f=duplex) offset=(1);
   run;
%enddot:
%mend dotplot;

 /*-----------------------------------------*
  |  Macro to generate a format of the form |
  |    1 ="&val1"  2="&val2" ...            |
  |  for observation labels on the y axis.  |
  *-----------------------------------------*/
%macro makefmt(nval);
  %if &sysver < 6 & "&sysscp"="CMS"
      %then %do;
        x set cmstype ht;              /* For SAS 5.18 on CMS, must    */
        x erase _yname_ text *;        /* erase format so that dotplot */
        x set cmstype rt;              /* can be used more than once   */
      %end;                            /* in a single SAS session      */
  %local i ;
  proc format;
       value _yname_
    %do i=1 %to &nval ;
       &i = "&&val&i"
       %end;
       ;
%mend makefmt;
 /*-------------------------------------------------------------------*
  * LOWESS SAS     Locally weighted robust scatterplot smoothing      *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  21 Apr 1989 09:21:55                                    *
  * Revised:  11 Jun 1991 12:10:16                                    *
  * Version:  1.3                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro LOWESS(
       data=_LAST_,        /* name of input data set            */
       out=SMOOTH,         /* name of output data set           */
       x = X,              /* name of independent variable      */
       y = Y,              /* name of Y variable to be smoothed */
       id=,                /* optional row ID variable          */
       f = .50,            /* lowess window width               */
       iter=2,             /* total number of iterations        */
       plot=NO,            /* draw the plot?                    */
       name=LOWESS);       /* name for graphic catalog entry    */
proc sort data=&data;
   by &x;

proc iml;
start WLS( X, Y, W, B, I );      *-- Weighted least squares;
   x = j(nrow(x), 1, 1) || x;
   xpx = x` * diag( w ) * x;
   xpy = x` * diag( w ) * y;
   if abs(det(xpx)) > .00001
      then b   = inv(xpx) * xpy;
      else do;
         b = (y[loc(w^=0)])[:] // { 0 } ;
         print 'Singular matrix for observation', I;
      end;
finish;

start MEDIAN( W, M);         * calculate median ;
   n = nrow( W );
   R = rank( W );
   i = int((n+1)/2);
   i =  i || n-i+1;
   M = W[ R[i] ];
   M = .5 # M[+];
finish;

start ROBUST( R, WTS);       * calculate robustness weights;
    run median(abs(R), M);
    W = R / (6 # M);         * bisquare function;
    WTS = (abs(W) < 1) # (1 - W##2) ## 2;
finish;

start LOWESS( X, Y, F, STEPS, YHAT, RES, DELTA);
   n = nrow(X);
   if n < 2 then do;
      yhat = y;
      return;
      end;
   q = round( f * n);      * # nearest neighbors;

   res  = y;
   yhat = J(n,1,0);
   delta= J(n,1,1);        * robustness weights;
   if steps <= 0 then steps=1;
   do it = 1 to steps;
      do i = 1 to n;
         dist = abs( x - x[i] );      * distance to each other pt;
         r = rank( dist );
         s = r; s[r]=1:n;
         near =  s[1:q] ;             * find the q nearest;
         nx = x [ near ];
         ny = y [ near ];
         d  = dist[ near[q] ];        * distance to q-th nearest;
         if d > 0 then do;
            u = abs( nx - x[i] ) / d ;
            wts = (u < 1) # (1 - u##3) ## 3; * neighborhood wts;
            wts = delta[ near ] # wts;
            if sum(wts[2:q]) > .0001 then do;
               run wls( nx, ny, wts, b, i );
               yhat[i] = (1 || x[i]) * b;      * smoothed value;
               end;
            else yhat[i] = y[i];
         end;
         else do;
            yhat[i] = ny [+] /q;
         end;
      end;
      res = y - yhat;
      run robust(res,delta);
   end;
finish;

*-- Main routine;
  use &data;
  %if &id.NULL=NULL %then %let rowid=;
  %else %let rowid=rowname=&id;
  read all var{&x &y} into xy[ colname=vars &rowid ];
  close &data;
  x = xy[,1];
  y = xy[,2];
  run lowess(x, y, &f, &iter, yhat, res, weight);
  xyres =x || y || yhat || res || weight;
  cname = vars || {"_YHAT_" "_RESID_" "_WEIGHT_" };
  print "Data, smoothed fit, residuals and weights",
        xyres[ colname=cname &rowid ];

*-- Output results to data set &out ;
  xys =    yhat || res || weight;
  cname = {"_YHAT_" "_RESID_" "_WEIGHT_" };

  create &out from xys [ colname=cname ];
     append from xys;
quit;
 /*--------------------------------------------*
  | Merge data with smoothed results.          |
  | (In a data step to retain variable labels) |
  *--------------------------------------------*/
data &out;
   merge &data(keep=&x &y &id)
         &out ;
   label _yhat_ = "Smoothed &y"
         _weight_='Lowess weight';
%if %upcase(&PLOT)=YES %then %do;
proc gplot data=&out ;
  plot &y     * &x = 1
       _yhat_ * &x = 2
       / overlay frame
         vaxis=axis1 haxis=axis2
         name="&name" ;
  symbol1 v=+ h=1.5  i=none c=black;
  symbol2 v=none i=join c=red;
  axis1   label=(h=1.5 f=duplex a=90 r=0) value=(h=1.3);
  axis2   label=(h=1.5 f=duplex)          value=(h=1.3);
run;
%end;
%mend LOWESS;
 /*-------------------------------------------------------------------*
  * LOWESS2 SAS     Locally weighted robust scatterplot smoothing     *
  *              **** USE WITH VERSION 6 ONLY ****                    *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  21 Apr 1989 09:21:55                                    *
  * Revised:  11 Jun 1991 12:10:16                                    *
  * Version:  1.3                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro LOWESS(
       data=_LAST_,        /* name of input data set            */
       out=SMOOTH,         /* name of output data set           */
       x = X,              /* name of independent variable      */
       y = Y,              /* name of Y variable to be smoothed */
       id=,                /* optional row ID variable          */
       f = .50,            /* lowess window width               */
       iter=2,             /* total number of iterations        */
       plot=NO,            /* draw the plot?                    */
       name=LOWESS);       /* name for graphic catalog entry    */
proc sort data=&data;
   by &x;

proc iml;
start WLS( X, Y, W, B, I );      *-- Weighted least squares;
   x = j(nrow(x), 1, 1) || x;
   xpx = t(x) * diag( w ) * x;
   xpy = t(x) * diag( w ) * y;
   if abs(det(xpx)) > .00001
      then b   = inv(xpx) * xpy;
      else do;
         b = (y[loc(w^=0)])[:] // { 0 } ;
         print 'Singular matrix for observation', I;
      end;
finish;

start MEDIAN( W, M);         * calculate median ;
   n = nrow( W );
   R = rank( W );
   i = int((n+1)/2);
   i =  i || n-i+1;
   M = W[ R[i] ];
   M = .5 # M[+];
finish;

start ROBUST( R, WTS);       * calculate robustness weights;
    run median(abs(R), M);
    W = R / (6 # M);         * bisquare function;
    WTS = (abs(W) < 1) # (1 - W##2) ## 2;
finish;

start LOWESS( X, Y, F, STEPS, YHAT, RES, DELTA);
   n = nrow(X);
   if n < 2 then do;
      yhat = y;
      return;
      end;
   q = round( f * n);      * # nearest neighbors;

   res  = y;
   yhat = J(n,1,0);
   delta= J(n,1,1);        * robustness weights;
   if steps <= 0 then steps=1;
   do it = 1 to steps;
      do i = 1 to n;
         dist = abs( x - x[i] );      * distance to each other pt;
         r = rank( dist );
         s = r; s[r]=1:n;
         near =  s[1:q] ;             * find the q nearest;
         nx = x [ near ];
         ny = y [ near ];
         d  = dist[ near[q] ];        * distance to q-th nearest;
         if d > 0 then do;
            u = abs( nx - x[i] ) / d ;
            wts = (u < 1) # (1 - u##3) ## 3; * neighborhood wts;
            wts = delta[ near ] # wts;
            if sum(wts[2:q]) > .0001 then do;
               run wls( nx, ny, wts, b, i );
               yhat[i] = (1 || x[i]) * b;      * smoothed value;
               end;
            else yhat[i] = y[i];
         end;
         else do;
            yhat[i] = ny [+] /q;
         end;
      end;
      res = y - yhat;
      run robust(res,delta);
   end;
finish;

*-- Main routine;
  use &data;
  %if &id.NULL=NULL %then %let rowid=;
  %else %let rowid=rowname=&id;
  read all var{&x &y} into xy[ colname=vars &rowid ];
  close &data;
  x = xy[,1];
  y = xy[,2];
  run lowess(x, y, &f, &iter, yhat, res, weight);
  xyres =x || y || yhat || res || weight;
  cname = vars || {"_YHAT_" "_RESID_" "_WEIGHT_" };
  print "Data, smoothed fit, residuals and weights",
        xyres[ colname=cname &rowid ];

*-- Output results to data set &out ;
  xys =    yhat || res || weight;
  cname = {"_YHAT_" "_RESID_" "_WEIGHT_" };

  create &out from xys [ colname=cname ];
     append from xys;
quit;
 /*--------------------------------------------*
  | Merge data with smoothed results.          |
  | (In a data step to retain variable labels) |
  *--------------------------------------------*/
data &out;
   merge &data(keep=&x &y &id)
         &out ;
   label _yhat_ = "Smoothed &y"
         _weight_='Lowess weight';
%if %upcase(&PLOT)=YES %then %do;
proc gplot data=&out ;
  plot &y     * &x = 1
       _yhat_ * &x = 2
       / overlay frame
         vaxis=axis1 haxis=axis2
         name="&name" ;
  symbol1 v=+ h=1.5  i=none c=black;
  symbol2 v=none i=join c=red;
  axis1   label=(h=1.5 f=duplex a=90 r=0) value=(h=1.3);
  axis2   label=(h=1.5 f=duplex)          value=(h=1.3);
run;
%end;
%mend LOWESS;
 /*-------------------------------------------------------------------*
  * NQPLOT SAS     SAS macro for normal quantile-comparison plot      *
  *                                                                   *
  *  minimal syntax: %nqplot (data=dataset,var=variable);             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  16 Feb 1989 21:43:25                                    *
  * Revised:  11 Jun 1991 12:12:55                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro nqplot (
        data=_LAST_,    /* input data set                      */
        var=x,          /* variable to be plotted              */
        out=nqplot,     /* output data set                     */
        mu=MEDIAN,      /* est of mean of normal distribution: */
                        /*  MEAN, MEDIAN or literal value      */
        sigma=HSPR,     /* est of std deviation of normal:     */
                        /*  STD, HSPR, or literal value        */
        stderr=YES,     /* plot std errors around curves?      */
        detrend=YES,    /* plot detrended version?             */
        lh=1.5,         /* height for axis labels              */
        anno=,          /* name of input annotate data set     */
        name=NQPLOT,    /* name of graphic catalog entries     */
        gout=);         /* name of graphic catalog             */

%let stderr=%UPCASE(&stderr);
%let sigma=%UPCASE(&sigma);
%let detrend=%UPCASE(&detrend);
%if &sigma=HSPR    %then %let sigma=HSPR/1.349;
%if &anno^=%str()  %then %let anno=ANNOTATE=&anno;
%if &gout^=%str()  %then %let gout=GOUT=&gout;


data pass;
  set &data;
  _match_=1;
  if &var ne . ;                * get rid of missing data;

proc univariate noprint;        * find n, median and hinge-spread;
   var &var;
   output out=n1 n=nobs median=median qrange=hspr mean=mean std=std;
data n2; set n1;
   _match_=1;

data nqplot;
   merge pass n2;
   drop _match_;
   by _match_;

proc sort data=nqplot;
   by &var;
run;

data &out;
   set nqplot;
   drop sigma hspr nobs median std mean ;
   sigma = &sigma;
   _p_=(_n_ - .5)/nobs;                 * cumulative prob.;
   _z_=probit(_p_);                     * unit-normal Quantile;
   _se_=(sigma/((1/sqrt(2*3.1415926))*exp(-(_z_**2)/2)))
      *sqrt(_p_*(1-_p_)/nobs);          * std. error for normal quantile;
  _normal_= sigma * _z_ + &mu ;         * corresponding normal quantile;
   _resid_ = &var - _normal_;           * deviation from normal;
   _lower_ = _normal_ - 2*_se_;         * +/- 2 SEs around fitted line;
   _upper_ = _normal_ + 2*_se_;
   _reslo_  = -2*_se_;                  * +/- 2 SEs ;
   _reshi_   = 2*_se_;
  label _z_='Normal Quantile'
        _resid_='Deviation From Normal';
  run;
 /*-
 proc plot;
   plot &var * _z_='*'
        _normal_ * _z_='-'
        _lower_ * _z_='+'
        _upper_ * _z_='+' / overlay;       * observed and fitted values;
   plot _resid_ * _z_='*'
        _reslo_ * _z_='+'
        _reshi_ * _z_='+' / overlay vref=0; * deviation from fitted line;
   run;
 -*/
proc gplot data=&out &anno &gout ;
  plot &var     * _z_= 1
       _normal_ * _z_= 2
  %if &stderr=YES %then %do;
       _lower_ * _z_= 3
       _upper_ * _z_= 3 %end;
       / overlay frame
         vaxis=axis1 haxis=axis2
         hminor=1 vminor=1
         name="&name" ;
%if &detrend=YES %then %do;
  plot _resid_ * _z_= 1
  %if &stderr=YES %then %do;
       _reslo_ * _z_= 3
       _reshi_ * _z_= 3 %end;
       / overlay
         vaxis=axis1 haxis=axis2
         vref=0 frame
         hminor=1 vminor=1
         name="&name" ;
%end;
%let vh=1;           *-- value height;
%if &lh >= 1.5 %then %let vh=1.5;
%if &lh >= 2.0 %then %let vh=1.8;
  symbol1 v=+ h=1.1 i=none c=black l=1;
  symbol2 v=none   i=join  c=blue  l=3 w=2;
  symbol3 v=none   i=join  c=green l=20;
  axis1  label=(f=duplex a=90 r=0 h=&lh) value=(h=&vh);
  axis2  label=(f=duplex h=&lh) value=(h=&vh);
run;
%mend;
 /*-------------------------------------------------------------------*
  * OUTLIER SAS    Robust multivariate outlier detection              *
  *                                                                   *
  * Macro to calculate robust Mahalanobis distances for each          *
  * observation in a dataset. The results are robust in that          *
  * potential outliers do not contribute to the distance of any       *
  * other observations.                                               *
  *                                                                   *
  * The macro makes one or more passes through the data. Each         *
  * pass assigns 0 weight to observations whose DSQ value             *
  * has prob < PVALUE. The number of passes should be determined      *
  * empirically so that no new observations are trimmed on the        *
  * last pass.                                                        *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  16 Jan 1989 18:38:18                                    *
  * Revised:  11 Jun 1991 12:16:31                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro OUTLIER(
         data=_LAST_,      /* Data set to analyze            */
         var=_NUMERIC_,    /* input variables                */
         id=,              /* ID variable for observations   */
         out=CHIPLOT,      /* Output dataset for plotting    */
         pvalue=.1,        /* Prob < pvalue -> weight=0      */
         passes=2,         /* Number of passes               */
         print=YES);       /* Print OUT= data set?           */

 /*-------------------------------------------------------*
  | Add WEIGHT variable. Determine number of observations |
  | and variables, and create macro variables.            |
  *-------------------------------------------------------*/
data in;
   set &data end=lastobs;
   array invar{*} &var;
   _weight_ = 1;               /* Add weight variable */
   if ( lastobs ) then do;
      call symput('NOBS', _n_);
      call symput('NVAR', left(put(dim(invar),3.)) );
      end;

%do pass = 1 %to &PASSES;
   %if &pass=1 %then %let in=in;
               %else %let in=trimmed;
 /*--------------------------------------------------------------*
  | Transform variables to scores on principal components.       |
  | Observations with _WEIGHT_=0 are not used in the calculation,|
  | but get component scores based on the remaining observations.|
  *--------------------------------------------------------------*/
   proc princomp std noprint data=&in out=prin;
      var &var;
      freq _weight_;

 /*-----------------------------------------------------------*
  | Calculate Mahalanobis D**2 and its probability value. For |
  | standardized principal components, D**2 is just the sum   |
  | of squares. Output potential outliers to separate dataset.|
  *-----------------------------------------------------------*/
   data out1    (keep=pass case &id dsq prob)
        trimmed (drop=pass case );
      set prin ;
      pass = &pass;
      case = _n_;

      dsq = uss(of prin1-prin&nvar);    /* Mahalanobis D**2 */
      prob = 1 - probchi(dsq, &nvar);
      _weight_ = (prob > &pvalue);
      output trimmed;
      if _weight_ = 0 then do;
         output out1   ;
         end;
   run;
   proc append base=outlier data=out1;
%end;
   proc print data=outlier;
   title2 'Observations trimmed in calculating Mahalanobis distance';
 /*------------------------------------------*
  | Prepare for Chi-Square probability plot. |
  *------------------------------------------*/
proc sort data=trimmed;
   by dsq;
data &out;
   set trimmed;
   drop prin1 - prin&nvar;
   _weight_ = prob > &pvalue;
   expected = 2 * gaminv(_n_/(&nobs+1), (&nvar/2));

%if &print=yes %then %do;
proc print data=&out;
   %if &id ^=%str() %then
   %str(id &id;);
   title2 'Possible multivariate outliers have _WEIGHT_=0';
%end;

%if &ID = %str() %then %let SYMBOL='*';
                 %else %let SYMBOL=&ID;
proc plot data=&out;
   plot dsq      * expected = &symbol
        expected * expected = '.'   /overlay hzero vzero;
title2 'Chi-Squared probability plot for multivariate outliers';
run;
%done:
proc datasets nofs nolist;
   delete outlier out1;
%mend outlier;
 /*-------------------------------------------------------------------*
  * PARTIAL SAS - IML macro program for partial regression residual   *
  *               plots. (Version 5 only)                             *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  23 Jan 1989 16:11:15                                    *
  * Revised:  9 Jul 1991 14:37:40                                     *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro PARTIAL(
        data = _LAST_,  /* name of input data set               */
        yvar =,         /* name of dependent variable           */
        xvar =,         /* list of independent variables        */
        id =,           /* ID variable                          */
        label=INFL,     /* label ALL, NONE, or INFLuential obs  */
        out =,          /* output data set: partial residuals   */
        gout=gseg,      /* name of graphic catalog              */
        name=PARTIAL);  /* name of graphic catalog entries      */

%let label = %UPCASE(&label);
Proc IML;
start axes (xa, ya, origin, len, labels);
   col= 'BLACK';
   ox = origin[1,1];
   oy = origin[1,2];
   call gxaxis(origin,len,xa,7) color=col format='7.1';
   call gyaxis(origin,len,ya,7) color=col format='7.1';
   xo = ox + len/2 - length(labels[1])/2;
   yo = oy - 8;
   call gscript(xo,yo,labels[1]) color=col;
   xo = ox - 12;
   yo = oy + len;
   if nrow(labels)>1 | ncol(labels)>1
      then call gscript(xo,yo,labels[2]) angle=270 rotate=90 color=col;
finish;

*-----Find partial residuals for each variable-----;
start partial(x, y, names, obs, uv, uvname );
   k = ncol(x);
   n = nrow(x);
   yname = names[,k+1];
   k1= k + 1;                  *-- number of predictors;
   x = j( n , 1 , 1) || x;     *-- add column of 1s;
   name1 = { 'INTCEPT'};
   names = name1 || names[,1:k];

   *----- module to fit one regression ----------;
   start reg (y, x, b, res, yhat, h, rstudent);
      n = nrow(x);
      p = ncol(x);
      xpx = x` * x;
      xpy = x` * y;
      xpxi= inv(xpx);
      b   = xpxi * xpy;
      yhat= x * b;
      res = y - yhat;
      h   = vecdiag(x * xpxi * x`);
      sse = ssq(res);
      sisq= j(n,1,sse) - (res##2) / (1-h);
      sisq= sisq / (n-p-1);
      rstudent = res / sqrt( sisq # (1-h) );
   finish;

   run reg( y,  x, b, res, yhat, hat, rstudent );
   print "Full regression";
   print "Regression weights" , b[ rowname=names ];
   lev = hat > 2*k1/n;
   if any( lev ) then do;
      l = loc(lev)`;
      xl=  x[l ,];
      Print "High leverage points", L XL [colname=names ];
   end;
   flag = lev | (rstudent > 2);

   do i = 1 to k1;
      name = names[,i];
      reset noname;
      free others;
      do j = 1 to k1;
         if j ^=i then others = others || j;
      end;
      run reg( y,    x[, others], by, ry, fy, hy, sry );
      run reg( x[,i],x[, others], bx, rx, fx, hx, srx );
      uv = uv || ry ||rx;
      uvname = uvname || concat({'U'},name)
                      || concat({'V'},name);

      if i>1 then do;
       /**--------------------------------**
        | Start IML graphics               |
        **--------------------------------**/
       %if &sysver < 6 %then %do;
          %let lib=%scan(&gout,1,'.');
          %let cat=%scan(&gout,2,'.');
          %if &cat=%str() %then %do;
              %let cat=&lib;
              %let lib=work;
              %end;
          call gstart gout={&lib &cat}
                name="&name"
                descript="Partial regression plot for &data";
       %end;
       %else %do;     /* Version 6 */
          call gstart("&gout");
          call gopen("&name",1,"Partial regression plot for &data");
       %end;

         labels = concat( {"Partial "}, name )  ||
                  concat( {"Partial "}, yname ) ;
         run axes(rx,ry,{15 15}, 75, labels) ;
         call gpoint(rx,ry) color = 'BLACK';

         *-- Draw regression line from slope;
         xs = rx[<>] // rx[><];
         ys = b[i] * xs;
         call gdraw(xs, ys, 3, 'BLUE');

         *-- Mark influential points and large residuals;
         %if &label ^= NONE %then %do;
            outy = ry[ loc(flag) ];
            outx = rx[ loc(flag) ];
            outl = obs[ loc(flag) ];
            call gpoint(outx, outy,19) color ='RED';
            call gtext(outx,outy,outl) color ='RED';
         %end;
         %if &label = ALL %then %do;
            outy = ry[ loc(^flag) ];
            outx = rx[ loc(^flag) ];
            outl = obs[ loc(^flag) ];
            call gtext(outx,outy,outl) color ='BLACK';
         %end;
         call gshow;
      end;
   end;
   print "Partial Residuals", uv[ colname=uvname];
finish;  /* end of partial */

*-----read the data and prepare partial regression plots----;
     use &data;
     %if &id ^= %str() %then %do;
        read all var{&xvar} into  x[ rowname=&id colname=xname ];
     %end;
     %else %do;
        read all var{&xvar} into  x[ colname=xname ];
        %let id = obs;
        obs = char(1:nrow(x),3,0);
     %end;
     read all var{&yvar } into  y[ colname=yname ];
     names = xname || yname;
     run partial(x, y, names, &id, uv, uvname);
     %if &out ^= %str() %then %do;
        create &out from uv;
        append from uv;
     %end;
quit;
%mend PARTIAL;
 /*-------------------------------------------------------------------*
  * PARTIAL2 SAS- IML macro program for partial regression residual   *
  *               plots.                                              *
  *               ***** USE IN VERSION 6 ONLY *****                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  23 Jan 1989 16:11:15                                    *
  * Revised:  9 Jul 1991 14:37:40                                     *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro PARTIAL(
        data = _LAST_,  /* name of input data set               */
        yvar =,         /* name of dependent variable           */
        xvar =,         /* list of independent variables        */
        id =,           /* ID variable                          */
        label=INFL,     /* label ALL, NONE, or INFLuential obs  */
        out =,          /* output data set: partial residuals   */
        gout=gseg,      /* name of graphic catalog              */
        name=PARTIAL);  /* name of graphic catalog entries      */

%let label = %UPCASE(&label);
Proc IML worksize=100;
start axes (origin, len, labels, xa, ya);
   col= 'BLACK';
   ox = origin[1,1];
   oy = origin[1,2];

   /*---obtain min and max---*/
   xmin=min(xa);
   xmax=max(xa);
   ymin=min(ya);
   ymax=max(ya);

   /*---define viewport and window for the application---*/
   p=(origin[1]||origin[2])//((origin[1]+len)||(origin[2]+len));
   call gport(p);
   w=(xmin||ymin)//(xmax||ymax);
   call gwindow(w);

    call gxaxis(xmin||ymin,xmax-xmin,10,,,'7.1',,,col,'n');
    call gyaxis(xmin||ymin,ymax-ymin,8,,,'7.1',,,col,'n');

    /*---restore to default window and viewport for axes labels---*/
    call gport({0,0,100,100});
    call gwindow({0,0,100,100});

   xo = ox + len/2 - length(labels[1])/2;
   yo = oy - 8;
   call gscript(25,95,'Partial regression residuals',
               ,,1.5,'complex','BLACK');
   call gscript(xo,yo,labels[1],,,,,col);
   xo = ox - 5;
   yo = oy + len;
   if nrow(labels)>1 | ncol(labels)>1
      then call gscript(xo-5,yo,labels[2],-90,90,,,col);

   p=(origin[1]||origin[2])//((origin[1]+len)||(origin[2]+len));
   call gport(p);
   w=(xmin||ymin)//(xmax||ymax);
   call gwindow(w);
finish;

*-----Find partial residuals for each variable-----;
start partial(x, y, names, obs, uv, uvname );
   k = ncol(x);
   n = nrow(x);
   yname = names[,k+1];
   k1= k + 1;                  *-- number of predictors;
   x = j( n , 1 , 1) || x;     *-- add column of 1s;
   name1 = { 'INTCEPT'};
   names = name1 || names[,1:k];

   *----- module to fit one regression ----------;
   start reg (y, x, b, res, yhat, h, rstudent);
      n = nrow(x);
      p = ncol(x);
      xpx = t(x) * x;
      xpy = t(x) * y;
      xpxi= inv(xpx);
      b   = xpxi * xpy;
      yhat= x * b;
      res = y - yhat;
      h   = vecdiag(x * xpxi * x`);
      sse = ssq(res);
      sisq= j(n,1,sse) - (res##2) / (1-h);
      sisq= sisq / (n-p-1);
      rstudent = res / sqrt( sisq # (1-h) );
   finish;

   run reg( y,  x, b, res, yhat, hat, rstudent );
   print "Full regression";
   print "Regression weights" , b[ rowname=names ];
   lev = hat > 2*k1/n;
   if any( lev ) then do;
      l = loc(lev)`;
      xl=  x[l ,];
      Print "High leverage points", L XL [colname=names ];
   end;
   flag = lev | (rstudent > 2);

   do i = 1 to k1;
      name = names[,i];
      reset noname;
      free others;
      do j = 1 to k1;
         if j ^=i then others = others || j;
      end;
      run reg( y,    x[, others], by, ry, fy, hy, sry );
      run reg( x[,i],x[, others], bx, rx, fx, hx, srx );
      uv = uv || ry ||rx;
      uvname = uvname || concat({'U'},name)
                      || concat({'V'},name);

      if i>1 then do;
       /**--------------------------------**
        | Start IML graphics               |
        **--------------------------------**/
       %if &sysver < 6 %then %do;
          %let lib=%scan(&gout,1,'.');
          %let cat=%scan(&gout,2,'.');
          %if &cat=%str() %then %do;
              %let cat=&lib;
              %let lib=work;
              %end;
          call gstart gout={&lib &cat}
                name="&name"
                descript="Partial regression plot for &data";
       %end;
       %else %do;     /* Version 6 */
          call gstart("&gout");
          call gopen("&name",1,"Partial regression plot for &data");
       %end;

         labels = concat( {"Partial "}, name )  ||
                  concat( {"Partial "}, yname ) ;

         run axes({10 10}, 75, labels, rx, ry) ;
         call gpoint(rx,ry,,'BLACK');

         *-- Draw regression line from slope;
         xs = rx[<>] // rx[><];
         ys = b[i] * xs;
         call gdraw(xs, ys, 3, 'BLUE');

         *-- Mark influential points and large residuals;
         %if &label ^= NONE %then %do;
            outy = ry[ loc(flag) ];
            outx = rx[ loc(flag) ];
            outl = obs[ loc(flag) ];
            call gpoint(outx, outy,,'RED');
            call gtext(outx,outy,outl,'RED');
         %end;
         %if &label = ALL %then %do;
            outy = ry[ loc(^flag) ];
            outx = rx[ loc(^flag) ];
            outl = obs[ loc(^flag) ];
            call gtext(outx,outy,outl,'BLACK');
         %end;
         call gshow;
      end;
   end;
   print "Partial Residuals", uv[ colname=uvname];
finish;  /* end of partial */

*-----read the data and prepare partial regression plots----;
     use &data;
     %if &id ^= %str() %then %do;
        read all var{&xvar} into  x[ rowname=&id colname=xname ];
     %end;
     %else %do;
        read all var{&xvar} into  x[ colname=xname ];
        %let id = obs;
        obs = char(1:nrow(x),3,0);
     %end;
     read all var{&yvar } into  y[ colname=yname ];
     names = xname || yname;
     run partial(x, y, names, &id, uv, uvname);
     %if &out ^= %str() %then %do;
        create &out from uv;
        append from uv;
     %end;
quit;
%mend PARTIAL;
 /*-------------------------------------------------------------------*
  * SCATMAT SAS     Construct a scatterplot matrix - all pairwise     *
  *                 plots for n variables.                            *
  *                                                                   *
  * %scatmat(data=, var=, group=);                                    *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  4 Oct 1989 11:07:50                                     *
  * Revised:  24 May 1991 17:33:41                                    *
  * Version:  1.1                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *-------------------------------------------------------------------*/

%macro SCATMAT(
        data =_LAST_,          /* data set to be plotted             */
        var  =,                /* variables to be plotted            */
        group=,                /* grouping variable (plot symbol)    */
        symbols=%str(- + : $ = X _ Y),
        colors=BLACK RED GREEN BLUE BROWN YELLOW ORANGE PURPLE,
        gout=GSEG);            /* graphic catalog for plot matrix    */

 options nonotes dquote;
proc greplay igout=gseg nofs;
delete _all_;
quit;
*-- Parse variables list;
 %let var = %upcase(&var);
 data _null_;
 set &data (obs=1);
    %if %index(&var,-) > 0 or "&var"="_NUMERIC_" %then %do;

       * find the number of variables in the list and
         convert shorthand variable list to long form;
     length _vname_ $ 8 _vlist_ $ 200;
     array _xx_ &var;
     _vname_ = ' ';
     do over _xx_;
        call vname(_xx_,_vname_);
        if _vname_ ne "&group" then do;
           nvar + 1;
           if nvar = 1 then startpt = 1;
                       else startpt = length(_vlist_) + 2;
           endpt = length(_vname_);
           substr(_vlist_,startpt,endpt) = _vname_;
        end;
     end;
     call symput( 'VAR', _vlist_ );
   %end;
   %else %do;
     * find the number of variables in the list;
     nvar = n(of &var) + nmiss(of &var);
   %end;
   call symput('NVAR',trim(left(put(nvar,2.))));
 RUN;
%if &nvar < 2 or &nvar > 10 %then %do;
   %put Cannot do a scatterplot matrix for &nvar variables ;
   %goto DONE;
   %end;

 /*----------------------------------------------------*
  | Determine grouping variable and plotting symbol(s) |
  *----------------------------------------------------*/
%if &group = %str() %then %do;
   %let NGROUPS=1;
   %let plotsym=1;      /* SYMBOL for data panels  */
   %let plotnam=2;      /* for variable name panel */
   %end;
%else %do;
   %let plotsym=&group;
   *-- How many levels of group variable? --;
   proc freq data = &data;
      tables &group / noprint out=_DATA_;
   data _null_;
      set end=eof;
      ngroups+1;
      if eof then do;
         call symput( 'NGROUPS', put(ngroups,3.) );
      end;
    run;
    %let plotnam=%eval(&ngroups+1);
%end;

%gensym(n=&ngroups, ht=&nvar, symbols=&symbols, colors=&colors);
goptions NODISPLAY;         * device dependent;

title h=0.1 ' ';
%let plotnum=0;    * number of plots made;
%let replay = ;    * replay list;

%do i = 1 %to &nvar;                   /* rows */
   %let vi = %scan(&var , &i );
   proc means noprint data=&data;
      var &vi;
      output out=minmax min=min max=max;

   %do j = 1 %to &nvar;                /* cols */
      %let vj = %scan(&var , &j );
      %let plotnum = %eval(&plotnum+1);
      %let replay  = &replay &plotnum:&plotnum ;
      %*put plotting &vi vs. &vj ;

      %if &i = &j %then %do;           /* diagonal panel */
         data title;
            length text $8;
            set minmax;
            xsys = '1'; ysys = '1';
            x = 50; y = 50;
            text = "&vi";
            size = 2 * &nvar;
            function = 'LABEL';  output;

            x = 6; y = 6; position = '6';
            text = left(put(min, best6.));
            size = &nvar;
            output;

            x = 95; y = 95; position = '4';
            text = trim(put(max, best6.));
            size = &nvar;
            output;

         proc gplot data = &data;
            plot &vi * &vi = &plotnam
            / frame anno=title vaxis=axis1 haxis=axis1;
         axis1 label=none value=none major=(h=-%eval(&nvar-1))
               minor=none offset=(2);
         run;
      %end;

      %else %do;                       /* off-diagonal panel */
         proc gplot data = &data;
            plot &vi * &vj = &plotsym
            / frame nolegend vaxis=axis1 haxis=axis1;
         axis1 label=none value=none major=none minor=none offset=(2);
         run;
      %end;

   %end; /* cols */
%end;    /* rows */

goptions DISPLAY;         * device dependent;

%macro TDEF(nv, size, shift );
%* ---------------------------------------------------------------;
%* Generate a TDEF statement for a scatterplot matrix             ;
%* Start with (1,1) panel in upper left, and copy it across & down;
%* ---------------------------------------------------------------;
%local i j panl panl1 lx ly;

   TDEF scat&nv DES="scatterplot matrix &nv x &nv"
   %let panl=0;
   %let lx = &size;
   %let ly = %eval(100-&size);
   %do i = 1 %to &nv;
   %do j = 1 %to &nv;
       %let panl  = %eval(&panl + 1);
       %if &j=1 %then
          %do;
             %if &i=1 %then %do;      %* (1,1) panel;
               &panl/
                ULX=0  ULY=100   URX=&lx URY=100
                LLX=0  LLY=&ly   LRX=&lx LRY=&ly
                %end;
             %else
                %do;                  %* (i,1) panel;
                   %let panl1 = %eval(&panl - &nv );
               &panl/ copy= &panl1 xlatey= -&shift
                %end;
          %end;
       %else
          %do;
               %let panl1 = %eval(&panl - 1);
               &panl/ copy= &panl1 xlatex= &shift
          %end;
   %end;
   %end;
     %str(;);      %* end the TDEF statement;
%mend TDEF;

proc greplay igout=gseg
              gout=&gout  nofs
             template=scat&nvar
             tc=templt ;
%if &nvar = 2 %then %do;
  TDEF scat2 DES="scatterplot matrix 2x2"
           1/ ULX=0  ULY=100   URX=52  URY=100
              LLX=0  LLY=52    LRX=52  LRY=52
           2/ copy=1 XLATEX= 48       /*  Panels are numbered: */
           3/ copy=1 XLATEY=-48                /*    1   2     */
           4/ copy=3 XLATEX= 48;               /*    3   4     */
%end;

%if &nvar = 3 %then  %TDEF(&nvar,34,33);
%if &nvar = 4 %then  %TDEF(&nvar,25,25);
%if &nvar = 5 %then  %TDEF(&nvar,20,20);
%if &nvar = 6 %then  %TDEF(&nvar,17,16);
%if &nvar = 7 %then  %TDEF(&nvar,15,14);
%if &nvar = 8 %then  %TDEF(&nvar,13,12);
%if &nvar = 9 %then  %TDEF(&nvar,12,11);
%if &nvar =10 %then  %TDEF(&nvar,10,10);

   TREPLAY &replay;
%DONE:
  options notes;
%mend SCATMAT;


 /*----------------------------------------------------*
  |  Macro to generate SYMBOL statement for each GROUP |
  *----------------------------------------------------*/
%macro gensym(n=1, ht=1.5,
              symbols=%str(- + : $ = X _ Y),
              colors=BLACK RED GREEN BLUE BROWN YELLOW ORANGE PURPLE);
    %*-- note: only 8 symbols & colors are defined;
    %*--    revise if more than 8 groups (recycle);
  %local chr col k;
  %do k=1 %to &n ;
     %let chr =%scan(&symbols, &k,' ');
     %let col =%scan(&colors, &k, ' ');
     SYMBOL&k H=&HT V=&chr C=&col;
  %end;
  %let k=%eval(&n+1);
     SYMBOL&k v=none;
%mend gensym;
 /*-------------------------------------------------------------------*
  | STARS SAS      Star plot of multivariate data                     |
  |                Plots each observation as a star figure with one   |
  |                ray for each variable, ray length proportional to  |
  |                the size of that variable.                         |
  |                                                                   |
  | Reference: Chambers, Cleveland, Kleiner & Tukey, Graphical methods|
  |            for data analysis, Wadsworth, 1983. pp158-162.         |
  |-------------------------------------------------------------------|
  | Author:   Michael Friendly            <FRIENDLY@YORKVM1>          |
  | Created:  31 Mar 1988 00:15:25                                    |
  | Revised:  13 Mar 1991 16:21:39                                    |
  | Version:  1.1                                                     |
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *-------------------------------------------------------------------*/

%macro STARS(
        data=_LAST_,       /* Data set to be displayed             */
        var=,              /* Variables, as ordered around the     */
                           /* star from angle=0 (horizontal)       */
        id=,               /* Observation identifier  (char)       */
        minray=.1,         /* Minimum ray length, 0<=MINRAY<1      */
        across=5,          /* Number of stars across a page        */
        down=6             /* Number of stars down a page          */
        );
 /*----------------------------------------------------*
  |  Scale each variable to range from MINRAY to 1.0   |
  *----------------------------------------------------*/

PROC IML;
  reset;
  use &DATA;
  read all var{&ID} into  &ID;
  read all var{&VAR} into  X[colname=VARS ];
  print city;
  n = nrow( x);
  min = J( n , 1 ) * X[>< ,];
  max = J( n , 1 ) * X[<> ,];
  c = &MINRAY ;
  X = c + ( 1 - c ) * ( X - min ) / ( max - min );
  create SCALED from X[ rowname=&ID colname=VARS ];
  append from X[ rowname= &ID ];
  quit;
run;
  %put &DATA dataset variables scaled to range &MINRAY to 1;
proc print data=scaled;
 /*---------------------------------------*
  |  Find out how many variables and obs. |
  *---------------------------------------*/
data _null_;
   file print;
   array p(k) &var ;
   point=1;
   set scaled point=point nobs=nobs;
   do over p;         /* Loop to count variables*/
   end;
   k = k-1;
   put @10 "STARS plots for data set &DATA" /;
   put @10 'Number of variables    = ' k /;
   put @10 'Number of observations = ' nobs /;
   call symput('NV'  , left(put(k,   2.)));
   call symput('NOBS', put(nobs,5.));
   stop;     /* Don't forget this ! */
run;
 /*---------------------------------------------------*
  |  Text POSITIONs corresponding to rays of varying  |
  |  angle around the star                            |
  *---------------------------------------------------*/
proc format;
   value posn     0-22.5 = '6'  /* left, centered  */
               22.6-67.5 = 'C'  /* left, above     */
               67.6-112.5= 'B'  /* centered, above */
              112.6-157.5= 'A'  /* right, above    */
              157.6-202.5= '4'  /* right, centered */
              202.6-247.5= '7'  /* right, below    */
              247.6-292.5= 'E'  /* centered, below */
              other='F';        /* left, below     */
run;

 /*------------------------------------------*
  |  Construct ANNOTATE data set to draw and |
  |  label the star for each observation.    |
  *------------------------------------------*/
data stars;
     length function varname $8;
     array p(k) &var ;

     retain s1-s&nv c1-c&nv;
     retain cols   &across      /* number of observations per row  */
            rows   &down        /* number of rows per page         */
            xsys   '1'          /* use data percentage coordinates */
            ysys   '1'          /* for both X and Y                */
            lx ly page 0        /* cell X,Y and page  counters     */
            rx ry r;            /* cell radii                      */
     array s(k)  s1-s&nv;              /* sines of angle      */
     array c(k)  c1-c&nv;              /* cosines of angle    */

     drop cols rows rx ry cx cy s1-s&nv c1-c&nv &var;
     drop varname showvar;
     *--- precompute ray angles;
     if page=0 then do;
        do k= 1 to &nv;
           ang = 2 * 3.1415926 * (k-1)/&nv;
           s = sin( ang );
           c = cos( ang );
           p = 1.0;                    /* For variable key */
        end;
        x0 = 50; y0 = 50;
        r  = 30;
        size=2;
        text = 'Variable Assignment Key';
        x  = x0; y = 10;
        function = 'LABEL';   output;

        showvar=1;
        link DrawStar;                 /* Do variable key  */
        page+1;
        lx = 0;
        ly = 0;
     end;

     set scaled end=lastobs;
     label  =&id;
     showvar=0;

     *--- set size of one cell;
     if _n_=1 then do;
        rx= (100/cols)/2;
        ry= (100/rows)/2;
        r = .95 * min(rx,ry);
     end;

     /* (CX,CY) specify location of lower left corner */
     /*  as percent of data area                      */
     cx  = 100 * (lx) / cols;
     cy  = 100 * ((rows-1)-ly) / rows;

     function = 'LABEL';          /* Label the observation centered */
     size = round(r/12,.1);       /* at bottom of the cell          */
     size = min(max(.8,size),2);  /* .8 <= SIZE <= 2                */
     text = &id;
     position='5';
     x =rx+cx; y=2+cy;
     output;

     x0 = cx + rx;                     /* Origin for this star */
     y0 = cy + ry;

     link drawstar;
     if ( lastobs ) then do;
        call symput('PAGES',trim(left(page)));
        put 'STARS plot will produce ' page 'page(s).';
     end;
     lx + 1;                 /* next column */
     if lx = cols then do;
        lx = 0;
        ly + 1; end;         /* next row    */
     if ly = rows then do;
        lx = 0;
        ly = 0;
        page + 1; end;       /* next page   */
     return;

DrawStar:
     *-- Draw star outline;
     do k = 1 to &nv;
        x = x0 + p * r * c;
        y = y0 + p * r * s;
        if k=1 then function = 'POLY';
               else function = 'POLYCONT';
        output;
     end;

     *-- draw rays from center to each point;
     *-- label with the variable name if showvar=1;
     do k = 1 to &nv;
        x=x0; y=y0;
        function='MOVE';   output;
        x = x0 + p * r * c;
        y = y0 + p * r * s;
        function = 'DRAW'; output;
        if showvar = 1 then do;
           ang = 2 * 3.1415926 * (k-1)/&nv;
           varname= ' ';
           varname=scan("&var",K);
           text = trim(left(varname));
           position = left(put(180*ang/3.14159,posn.));
           function = 'LABEL';  output;
        end;
     end;
  return;
run;                         /* Force SAS to do it (DONT REMOVE)  */

 /*----------------------------------------*
  |  Plot each page with GSLIDE:           |
  |   - Copy observations for current page |
  |   - Draw plot                          |
  |   - Delete page data set               |
  *----------------------------------------*/
%do pg = 0 %to &pages;
   data slide&pg;                    /* Select current page to plot */
      set stars;
      if page = &pg;

   proc gslide annotate=slide&pg ;  /* Plot current page        */
   title;
   run;
   proc datasets lib=work; delete slide&pg;
%end; /* end of page */

%mend STARS;
 /*-------------------------------------------------------------------*
  * SYMPLOT SAS    SAS macro for symmetry plots                       *
  *                                                                   *
  * Produces any of the following plot types:                         *
  *    UPLO   - Upper distance-to-median vs. Lower distance-to-       *
  *             median                                                *
  *    MIDSPR - Mid value vs. Spread                                  *
  *    MIDZSR - Mid value vs. Squared normal quantile                 *
  *    POWER  - Centered mid value vs. Squared spread measure.        *
  *             The slope in this plot usually indicates a            *
  *             reasonable power for a tranformation to symmetry.     *
  *                                                                   *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  23 Feb 1989 19:12:23                                    *
  * Revised:  11 Jun 1991 12:25:14                                    *
  * Version:  1.0                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
 %macro SYMPLOT(
       data=_LAST_,     /* data to be analyzed                   */
       var=,            /* variable to be plotted                */
       plot=MIDSPR,     /* Type of plot(s): NONE, or any of      */
                        /* UPLO, MIDSPR, MIDZSQ, or POWER        */
       trim=0,          /* # or % of extreme obs. to be trimmed  */
       out=symplot,     /* output data set                       */
       name=SYMPLOT);   /* name for graphic catalog entry        */

%let plot = %upcase(&plot);

data analyze;
   set &data;
   keep &var;
   if &var =. then delete;

proc univariate data=analyze noprint;
   var &var;
   output out=stats n=nobs median=median;

%let pct  = %upcase(%scan(&trim,2));

data stats;
   set stats;
   trim = %scan(&trim,1) ;
   %if &pct = PCT %then %do;
   trim = floor( trim * nobs / 100 );
   %end;
   put 'SYMPLOT:' trim 'Observations trimmed at each extreme' ;

proc sort data=analyze out=sortup;
   by &var;
proc sort data=analyze out=sortdn;
   by descending &var;
   /* merge x(i) and x(n+1-i)    */
data &out;
   merge sortup(rename=(&var=frombot))        /* frombot = x(i)     */
         sortdn(rename=(&var=fromtop));       /* fromtop = x(n+1-i) */
   if _n_=1 then set stats;                   /* get nobs, median   */
   depth = _n_ ;
   if depth > trim ;                          /* trim extremes      */
   zsq = ( probit((depth-.5)/nobs) )**2;
   mid = (fromtop + frombot) / 2;
   spread = fromtop - frombot;
   lower = median - frombot;
   upper = fromtop - median;
   mid2  = mid - median;
   spread2 = (lower**2 + upper**2 ) / (4*median) ;
   if _n_ > (nobs+1)/2 then stop;
   label mid =  "Mid value of &var"
         lower= 'Lower distance to median'
         upper= 'Upper distance to median'
         zsq  = 'Squared Normal Quantile'
         mid2 = "Centered Mid Value of &var"
         spread2 = 'Squared Spread'
         ;
run;

%if %index(&PLOT,POWER) > 0 %then %do;
   *-- Annotate POWER plot with slope and power;
proc reg data=&out outest=parms noprint ;
   model mid2 = spread2;
data label;
   set parms(keep=spread2);
   xsys='1'; ysys='1';
   length text $12 function $8;
   x = 10;   y=90;
   function = 'LABEL';
   size = 1.4;
   style = 'DUPLEX';
   power = round(1-spread2, .5);
   position='6'; text = 'Slope: ' || put(spread2,f5.2);  output;
   position='9'; text = 'Power: ' || put(power,  f5.2);  output;
   %if &trim ^= 0 %then %do;
   %if &pct=PCT %then %let pct=%str( %%);
   position='3'; text = 'Trim : ' || put(%scan(&trim,1),  f3. )||"&pct";
      output;
   %end;
%end;

%if %length(&PLOT) > 0 &
    &PLOT ^= NONE %then %do;      /* Something to plot? */
proc gplot data=&out;
   *-- Upper vs. Lower plot;
   %if %index(&PLOT,UPLO) > 0 %then %do;
   plot upper * lower = 1
        upper * upper = 2
        / overlay
          vaxis=axis1 haxis=axis2 vm=1 hm=1 name="&name";
   symbol1 v=+ c=black;
   symbol2 v=none i=join c=black l=20;
   %end;
   axis1 label=(h=1.5 a=90 r=0) value=(h=1.2) offset=(2);
   axis2 label=(h=1.5) value=(h=1.5);

   *-- Mid vs. Spread plot;
   %if %index(&PLOT,MIDSPR) > 0 %then %do;
   plot mid   * spread = 1
        median* spread = 2
        / overlay
          vaxis=axis1 haxis=axis2 vm=1 hm=1 name="&name";
   symbol1 v=+    i=rl   c=black;
   symbol2 v=none i=join c=red l=20;
   %end;
   *-- Mid vs. ZSQ    plot;
   %if %index(&PLOT,MIDZSQ) > 0 %then %do;
   plot mid   * zsq    = 1
        median* zsq    = 2
        / overlay
          vaxis=axis1 haxis=axis2 vm=1 hm=1 name="&name";
   symbol1 v=+    i=rl   c=black;
   symbol2 v=none i=join c=red l=20;
   %end;
   *-- Mid2 vs. Spread2    plot;
   %if %index(&PLOT,POWER) > 0 %then %do;
   plot mid2  * spread2= 1
        / overlay vref=0 lvref=20 cvref=red anno=label
          vaxis=axis1 haxis=axis2 vm=1 hm=1 name="&name";
   symbol1 v=+    i=rl   c=black;
   symbol2 v=none i=join c=red l=20;
   %end;
run;
%end;
%mend SYMPLOT;
 /*-------------------------------------------------------------------*
  * TWOWAY SAS     Analysis of two way tables                         *
  *                (Version 5 only)                                   *
  * Macro for analysis of two way tables, including Tukey's           *
  * 1df test for non-additivity, and graphical display of             *
  * additive fit, together with a diagnostic plot for                 *
  * removable non-additivity.                                         *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  11 Dec 1989 10:51:22                                    *
  * Revised:  11 Jun 1991 12:32:01                                    *
  * Version:  1.2                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro TWOWAY(
        data=_LAST_,        /* Data set to be analyzed         */
        var=,               /* list of variables: cols of table*/
        id=,                /* row identifier: char variable   */
        response=Response,  /* Label for response on 2way plot */
        plot=FIT DIAGNOSE,  /* What plots to do?               */
        name=TWOWAY,        /* Name for graphic catalog plots  */
        gout=GSEG);         /* Name for graphic catalog        */

%if &var = %str() %then %do;
    %put ERROR: You must supply a VAR= variable list for columns;
    %goto DONE;
%end;
%if &id = %str() %then %do;
    %put ERROR: You must supply an ID= character variable;
    %goto DONE;
%end;
%let plot = %upcase(&plot);

proc iml;
   reset;
     use &data;
     read all into  y[colname=clabel rowname=&id] var { &var };
     r = nrow( y);
     c = ncol( y);
     rowmean = y[ , :];
     colmean = y[ : ,];
     allmean = y[ :  ];                        * grand mean ;

     roweff = rowmean - allmean;                 * row effects;
     coleff = colmean - allmean;                 * col effects;
     data = ( y       || rowmean || roweff ) //
            ( colmean || allmean || 0 ) //
            ( coleff  || 0       || 0 );

     rl    = &id    // {'COLMEAN','COLEFF'};
     cl    = clabel || {'ROWMEAN' 'ROWEFF'};
     print , data [ rowname = rl colname = cl ];

     jc = j( r , 1);
     jr = j( 1 , c);
     e = y - (rowmean * jr) - (jc * colmean) + allmean;
     print 'Interaction Residuals ',
           e [ rowname = rl colname = cl ];

     sse = e[ ## ];
     dfe = ( r - 1 ) # ( c - 1 );

     ssrow = roweff[## ,];  ssa = c * ssrow;
     sscol = coleff[ ,##];  ssb = r * sscol;
     product = ( roweff * coleff ) # y;
     d = product[ + ]  / ( ssrow # sscol );

     ssnon = ( ( product[ + ] ) ## 2 ) / ( ssrow # sscol );
     sspe = sse - ssnon;
     ss   = ssa   // ssb // sse // ssnon // sspe ;
     df   = (r-1) //(c-1)// dfe //  1    // dfe-1;

     ms = ss / df ; mspe=sspe/(dfe-1);
     f  = ms / (ms[{3 3 3 5 5},]);

     source=  { "Rows","Cols","Error","Non-Add","Pure Err"};
     srt = "SOURCE   ";
     sst = "   SS    ";
     dft = "   DF    ";
     mst = "   MS    ";
     ft  = "   F     ";
     reset noname;
     print 'ANALYSIS OF VARIANCE SUMMARY TABLE ',
           'with Tukey 1 df test for Non - Additivity ',,
           source[ colname=srt ]
           ss[ colname=sst format=9.3]  df[ colname=dft format=best8. ]
           ms[ colname=mst format=9.3]  f [ colname=ft];

     re = ( roweff * jr );
     cf = ( jc * coleff )  + allmean;

     compare = ( roweff * coleff ) / allmean;
     compare = shape( e ,0 , 1) ||
               shape( compare ,0 , 1) ||
               shape( re ,0 ,1) ||
               shape( cf ,0, 1);
     vl = { 'RESIDUAL' 'COMPARE' 'ROWEFF' 'COLFIT'};
     create compare from compare[ colname=vl ];
     append from compare;

     /* Calculate slope of Residuals on Comparison values */
     /* for possible power transformation                 */
     xy = compare[,{2 1}];
     slope = sum(xy[,1] # xy[,2]) / xy[##,1];
     slope = d || slope || (1-slope);
     print 'D = Coefficient of alpha ( i ) * beta ( j ) ' ,
           'Slope of regression of Residuals on Comparison values',
           '1 - slope = power for transformation',,
           slope[ colname={D Slope Power}];
    ;

start twoway;
 /*-------------------------------------------------------------*
  | Calculate points for lines in two-way display of fitted     |
  | value. Each point is (COLFIT+ROWEFF, COLFIT-ROWEFF).        |
  *-------------------------------------------------------------*/
    do i=1 to r;
       clo  = coleff[><]+allmean;
       from = from // (clo-roweff[i] || clo+roweff[i]);
       chi  = coleff[<>]+allmean;
       to   = to   // (chi-roweff[i] || chi+roweff[i]);
       labl = labl || rl[i];
       end;
    do j=1 to c;
       rlo  = roweff[><];
       to   = to   // (coleff[j]+allmean-rlo || coleff[j]+allmean+rlo);
       rhi  = roweff[<>];
       from = from // (coleff[j]+allmean-rhi || coleff[j]+allmean+rhi);
       labl = labl || cl[j];
       end;

    /*----------------------*
     | Find large residuals |
     *----------------------*/
    do i=1 to r;
    do j=1 to c;
       if abs(e[i, j]) > sqrt(mspe) then do;
          from = from // ((cf[i,j]-re[i,j])||(cf[i,j]+re[i,j]));
          to   = to   // ((cf[i,j]-re[i,j])||(cf[i,j]+re[i,j]+e[i,j]));
          end;
       end; end;

    /*----------------------------------*
     | Start IML graphics               |
     *----------------------------------*/
    %if &sysver < 6 %then %do;
       %let lib=%scan(&gout,1,'.');
       %let cat=%scan(&gout,2,'.');
       %if &cat=%str() %then %do;
           %let cat=&lib;
           %let lib=work;
           %end;
       call gstart gout={&lib &cat}
             name="&name" descript="Two-way plot for dataset &data";
    %end;
    %else %do;     /* Version 6 */
       call gstart("&gout");
       call gopen("&name",1,"Two-way plot for dataset &data");
    %end;

    /**--------------------------------**
     | Find scales for the two-way plot |
     **--------------------------------**/
    call gport({10 10, 90 90});
    call gyaxis( {10 10}, 80, from[,2]//to[,2], 5, 0, '5.0') ;
    call gscale( scale2, from[,2]//to[,2], 5);
    call gscript(3, 40, "&Response",'DUPLEX',3) angle=90;

    call gscale( scale1, from[,1]//to[,1], 5);
    window = scale1[1:2] || scale2[1:2];
    call gwindow(window);

    /*----------------------------------*
     | Draw lines for fit and residuals |
     *----------------------------------*/
    l = nrow(from);
    call gdrawl( from[1:r+c,],   to[1:r+c,])   style=1 color={"BLACK"};
    call gdrawl( from[r+c+1:l,], to[r+c+1:l,]) style=3 color={"RED"};

    /*----------------------------------------*
     | Plot row and column labels at margins; |
     *----------------------------------------*/
    xoffset=.04 * (to[<>,1]-to[><,1]);
    yoffset=0;
    do i=1 to r+c;
       if i>r then do;
          yoffset=-.04 * (to[<>,2]-to[><,2]);
          end;
       call gtext(xoffset+to[i,1],yoffset+to[i,2],labl[i]);
    end;
    call gshow;
    call gstop;
finish;

    %if %index(&plot,FIT) > 0 %then %do;
    run twoway;
    %end;
quit;

data compare;
   set compare;
   fit = colfit + roweff;
   data= fit + residual;
   diff= colfit - roweff;

   /* Print values for fit and diagnostic plots */
proc print data=compare;
   var data roweff colfit fit diff residual compare;
%if %index(&plot,PRINT) > 0 %then %do;
proc plot;
     plot data* diff = '+'
          fit * diff = '*'    / overlay;
proc plot;
     plot residual * compare / vpos=45;
%end;

%if %index(&plot,DIAGNOSE) > 0 %then %do;
proc gplot data=compare gout=&gout;
     plot residual * compare
        / vaxis=axis1 haxis=axis2
          vminor=1 hminor=1 name="&name" ;
     symbol1 v=- h=1.4 c=black i=rl;
     axis1 label=(a=90 r=0 h=1.5 f=duplex) value=(h=1.3);
     axis2 label=(h=1.5 f=duplex) value=(h=1.3);
     label residual = 'INTERACTION RESIDUAL'
           compare  = 'COMPARISON VALUE';
%end;

%DONE:
%mend TWOWAY;
 /*-------------------------------------------------------------------*
  * TWOWAY2 SAS    Analysis of two way tables                         *
  *                (Version 6 only)                                   *
  * Macro for analysis of two way tables, including Tukey's           *
  * 1df test for non-additivity, and graphical display of             *
  * additive fit, together with a diagnostic plot for                 *
  * removable non-additivity.                                         *
  *-------------------------------------------------------------------*
  *  Author:  Michael Friendly            <FRIENDLY@YORKVM1>          *
  * Created:  11 Dec 1989 10:51:22                                    *
  * Revised:  11 Jun 1991 12:32:01                                    *
  * Version:  1.2                                                     *
  *      From ``SAS System for Statistical Graphics, First Edition''  *
  *      Copyright(c) 1991 by SAS Institute Inc., Cary, NC, USA       *
  *                                                                   *
  *-------------------------------------------------------------------*/
%macro TWOWAY(
        data=_LAST_,        /* Data set to be analyzed         */
        var=,               /* list of variables: cols of table*/
        id=,                /* row identifier: char variable   */
        response=Response,  /* Label for response on 2way plot */
        plot=FIT DIAGNOSE,  /* What plots to do?               */
        name=TWOWAY,        /* Name for graphic catalog plots  */
        gout=GSEG);         /* Name for graphic catalog        */

%if &var = %str() %then %do;
    %put ERROR: You must supply a VAR= variable list for columns;
    %goto DONE;
%end;
%if &id = %str() %then %do;
    %put ERROR: You must supply an ID= character variable;
    %goto DONE;
%end;
%let plot = %upcase(&plot);

proc iml;
   reset;
     use &data;
     read all into  y[colname=clabel rowname=&id] var { &var };
     r = nrow( y);
     c = ncol( y);
     rowmean = y[ , :];
     colmean = y[ : ,];
     allmean = y[ :  ];                        * grand mean ;

     roweff = rowmean - allmean;                 * row effects;
     coleff = colmean - allmean;                 * col effects;
     data = ( y       || rowmean || roweff ) //
            ( colmean || allmean || 0 ) //
            ( coleff  || 0       || 0 );

     rl    = &id    // {'COLMEAN','COLEFF'};
     cl    = clabel || {'ROWMEAN' 'ROWEFF'};
     print , data [ rowname = rl colname = cl ];

     jc = j( r , 1);
     jr = j( 1 , c);
     e = y - (rowmean * jr) - (jc * colmean) + allmean;
     print 'Interaction Residuals ',
           e [ rowname = rl colname = cl ];

     sse = e[ ## ];
     dfe = ( r - 1 ) # ( c - 1 );

     ssrow = roweff[## ,];  ssa = c * ssrow;
     sscol = coleff[ ,##];  ssb = r * sscol;
     product = ( roweff * coleff ) # y;
     d = product[ + ]  / ( ssrow # sscol );

     ssnon = ( ( product[ + ] ) ## 2 ) / ( ssrow # sscol );
     sspe = sse - ssnon;
     ss   = ssa   // ssb // sse // ssnon // sspe ;
     df   = (r-1) //(c-1)// dfe //  1    // dfe-1;

     ms = ss / df ; mspe=sspe/(dfe-1);
     f  = ms / (ms[{3 3 3 5 5},]);

     source=  { "Rows","Cols","Error","Non-Add","Pure Err"};
     srt = "SOURCE   ";
     sst = "   SS    ";
     dft = "   DF    ";
     mst = "   MS    ";
     ft  = "   F     ";
     reset noname;
     print 'ANALYSIS OF VARIANCE SUMMARY TABLE ',
           'with Tukey 1 df test for Non - Additivity ',,
           source[ colname=srt ]
           ss[ colname=sst format=9.3]  df[ colname=dft format=best8. ]
           ms[ colname=mst format=9.3]  f [ colname=ft];

     re = ( roweff * jr );
     cf = ( jc * coleff )  + allmean;

     compare = ( roweff * coleff ) / allmean;
     compare = shape( e ,0 , 1) ||
               shape( compare ,0 , 1) ||
               shape( re ,0 ,1) ||
               shape( cf ,0, 1);
     vl = { 'RESIDUAL' 'COMPARE' 'ROWEFF' 'COLFIT'};
     create compare from compare[ colname=vl ];
     append from compare;

     /* Calculate slope of Residuals on Comparison values */
     /* for possible power transformation                 */
     xy = compare[,{2 1}];
     slope = sum(xy[,1] # xy[,2]) / xy[##,1];
     slope = d || slope || (1-slope);
     D1={"D" "Slope" "Power"};
     print 'D = Coefficient of alpha ( i ) * beta ( j ) ' ,
           'Slope of regression of Residuals on Comparison values',
           '1 - slope = power for transformation',,
           slope[ colname=D1];
    ;

start twoway;
 /*-------------------------------------------------------------*
  | Calculate points for lines in two-way display of fitted     |
  | value. Each point is (COLFIT+ROWEFF, COLFIT-ROWEFF).        |
  *-------------------------------------------------------------*/
    do i=1 to r;
       clo  = coleff[><]+allmean;
       from = from // (clo-roweff[i] || clo+roweff[i]);
       chi  = coleff[<>]+allmean;
       to   = to   // (chi-roweff[i] || chi+roweff[i]);
       labl = labl || rl[i];
       end;
    do j=1 to c;
       rlo  = roweff[><];
       to   = to   // (coleff[j]+allmean-rlo || coleff[j]+allmean+rlo);
       rhi  = roweff[<>];
       from = from // (coleff[j]+allmean-rhi || coleff[j]+allmean+rhi);
       labl = labl || cl[j];
       end;

    /*----------------------*
     | Find large residuals |
     *----------------------*/
    do i=1 to r;
    do j=1 to c;
       if abs(e[i, j]) > sqrt(mspe) then do;
          from = from // ((cf[i,j]-re[i,j])||(cf[i,j]+re[i,j]));
          to   = to   // ((cf[i,j]-re[i,j])||(cf[i,j]+re[i,j]+e[i,j]));
          end;
       end; end;

    /*----------------------------------*
     | Start IML graphics               |
     *---------------------------------**/
    %if &sysver < 6 %then %do;
       %let lib=%scan(&gout,1,'.');
       %let cat=%scan(&gout,2,'.');
       %if &cat=%str() %then %do;
           %let cat=&lib;
           %let lib=work;
           %end;
       call gstart gout={&lib &cat}
             name="&name" descript="Two-way plot for dataset &data";
    %end;
    %else %do;     /* Version 6 */
       call gstart("&gout");
       call gopen("&name",1,"Two-way plot for dataset &data");
    %end;

    /**--------------------------------**
     | Find scales for the two-way plot |
     **--------------------------------**/
    call gport({10 10, 90 90});
    call gyaxis( {10 10}, 80, 5, 0,,'5.0') ;
    call gscale( scale2,from[,2]//to[,2], 5);
    call gscript(3, 40,"&Response",90,,3,'DUPLEX');

    call gscale( scale1, from[,1]//to[,1], 5);
    window = scale1[1:2] || scale2[1:2];
    call gwindow(window);

    /*----------------------------------*
     | Draw lines for fit and residuals |
     *----------------------------------*/
    l = nrow(from);
    call gdrawl( from[1:r+c,],   to[1:r+c,],1,"black");
    call gdrawl( from[r+c+1:l,], to[r+c+1:l,],3,"RED");

    /*----------------------------------------*
     | Plot row and column labels at margins; |
     *----------------------------------------*/
    xoffset=.04 * (to[<>,1]-to[><,1]);
    yoffset=0;
    do i=1 to r+c;
       if i>r then do;
          yoffset=-.04 * (to[<>,2]-to[><,2]);
          end;
       call gtext(xoffset+to[i,1],yoffset+to[i,2],labl[i]);
    end;
    call gshow;
    call gstop;
finish;

    %if %index(&plot,FIT) > 0 %then %do;
    run twoway;
    %end;
quit;

data compare;
   set compare;
   fit = colfit + roweff;
   data= fit + residual;
   diff= colfit - roweff;

   /* Print values for fit and diagnostic plots */
proc print data=compare;
   var data roweff colfit fit diff residual compare;
%if %index(&plot,PRINT) > 0 %then %do;
proc plot;
     plot data* diff = '+'
          fit * diff = '*'    / overlay;
proc plot;
     plot residual * compare / vpos=45;
%end;

%if %index(&plot,DIAGNOSE) > 0 %then %do;
proc gplot data=compare gout=&gout;
     plot residual * compare
        / vaxis=axis1 haxis=axis2
          vminor=1 hminor=1 name="&name" ;
     symbol1 v=- h=1.4 c=black i=rl;
     axis1 label=(a=90 r=0 h=1.5 f=duplex) value=(h=1.3);
     axis2 label=(h=1.5 f=duplex) value=(h=1.3);
     label residual = 'INTERACTION RESIDUAL'
           compare  = 'COMPARISON VALUE';
%end;
run;

%DONE:
%mend TWOWAY;

/* The AUTO Data Set: Automobiles Data */

/* The AUTO data set contains the following variables for
   74 automobile models from the 1979 model year:

   MODEL:  make and model
   ORIGIN: region of origin (America, Europe, or Japan)
   PRICE:  price in dollars
   MPG:    gas mileage in miles per gallon
   REP77:  repair records for 1977, five-point scale (5=best, 1=worst)
   REP78:  repair records for 1978, five-point scale (5=best, 1=worst)
   HROOM:  headroom in inches
   RSEAT:  rear seat clearance (distance from front seat to rear seat back)
           in inches
   TRUNK:  trunk space in cubic feet
   WEIGHT: weight in pounds
   LENGTH: length in inches
   TURN:   turning diameter (clearance required to make a U-turn) in feet
   DISPLA: engine displacement in cubic inches
   GRATIO: gear ratio for high gear
*/

data auto;
   input model $ 1-17 origin $ 20  @24 price
         mpg rep78 rep77 hroom rseat trunk weight length
         turn displa gratio;
   label model  = 'MAKE & MODEL'
         price  = 'PRICE'
         mpg    = 'MILEAGE'
         rep78  = 'REPAIR RECORD 1978'
         rep77  = 'REPAIR RECORD 1977'
         hroom  = 'HEADROOM (IN.)'
         rseat  = 'REAR SEAT (IN.)'
         trunk  = 'TRUNK SPACE (CU FT)'
         weight = 'WEIGHT (LBS)'
         length = 'LENGTH (IN.)'
         turn   = 'TURN CIRCLE (FT)'
         displa = 'DISPLACEMENT (CU IN)'
         gratio = 'GEAR RATIO';
cards;
AMC CONCORD        A    4099 22 3 2 2.5 27.5 11 2930 186 40 121 3.58
AMC PACER          A    4749 17 3 1 3.0 25.5 11 3350 173 40 258 2.53
AMC SPIRIT         A    3799 22 . . 3.0 18.5 12 2640 168 35 121 3.08
AUDI 5000          E    9690 17 5 2 3.0 27.0 15 2830 189 37 131 3.20
AUDI FOX           E    6295 23 3 3 2.5 28.0 11 2070 174 36  97 3.70
BMW 320I           E    9735 25 4 4 2.5 26.0 12 2650 177 34 121 3.64
BUICK CENTURY      A    4816 20 3 3 4.5 29.0 16 3250 196 40 196 2.93
BUICK ELECTRA      A    7827 15 4 4 4.0 31.5 20 4080 222 43 350 2.41
BUICK LE SABRE     A    5788 18 3 4 4.0 30.5 21 3670 218 43 231 2.73
BUICK OPEL         A    4453 26 . . 3.0 24.0 10 2230 170 34 304 2.87
BUICK REGAL        A    5189 20 3 3 2.0 28.5 16 3280 200 42 196 2.93
BUICK RIVIERA      A   10372 16 3 4 3.5 30.0 17 3880 207 43 231 2.93
BUICK SKYLARK      A    4082 19 3 3 3.5 27.0 13 3400 200 42 231 3.08
CAD. DEVILLE       A   11385 14 3 3 4.0 31.5 20 4330 221 44 425 2.28
CAD. ELDORADO      A   14500 14 2 2 3.5 30.0 16 3900 204 43 350 2.19
CAD. SEVILLE       A   15906 21 3 3 3.0 30.0 13 4290 204 45 350 2.24
CHEV. CHEVETTE     A    3299 29 3 3 2.5 26.0  9 2110 163 34 231 2.93
CHEV. IMPALA       A    5705 16 4 4 4.0 29.5 20 3690 212 43 250 2.56
CHEV. MALIBU       A    4504 22 3 3 3.5 28.5 17 3180 193 41 200 2.73
CHEV. MONTE CARLO  A    5104 22 2 3 2.0 28.5 16 3220 200 41 200 2.73
CHEV. MONZA        A    3667 24 2 2 2.0 25.0  7 2750 179 40 151 2.73
CHEV. NOVA         A    3955 19 3 3 3.5 27.0 13 3430 197 43 250 2.56
DATSUN 200-SX      J    6229 23 4 3 1.5 21.0  6 2370 170 35 119 3.89
DATSUN 210         J    4589 35 5 5 2.0 23.5  8 2020 165 32  85 3.70
DATSUN 510         J    5079 24 4 4 2.5 22.0  8 2280 170 34 119 3.54
DATSUN 810         J    8129 21 4 4 2.5 27.0  8 2750 184 38 146 3.55
DODGE COLT         A    3984 30 5 4 2.0 24.0  8 2120 163 35  98 3.54
DODGE DIPLOMAT     A    5010 18 2 2 4.0 29.0 17 3600 206 46 318 2.47
DODGE MAGNUM XE    A    5886 16 2 2 3.5 26.0 16 3870 216 48 318 2.71
DODGE ST. REGIS    A    6342 17 2 2 4.5 28.0 21 3740 220 46 225 2.94
FIAT STRADA        E    4296 21 3 1 2.5 26.5 16 2130 161 36 105 3.37
FORD FIESTA        A    4389 28 4 . 1.5 26.0  9 1800 147 33  98 3.15
FORD MUSTANG       A    4187 21 3 3 2.0 23.0 10 2650 179 42 140 3.08
HONDA ACCORD       J    5799 25 5 5 3.0 25.5 10 2240 172 36 107 3.05
HONDA CIVIC        J    4499 28 4 4 2.5 23.5  5 1760 149 34  91 3.30
LINC. CONTINENTAL  A   11497 12 3 4 3.5 30.5 22 4840 233 51 400 2.47
LINC. CONT MARK V  A   13594 12 3 4 2.5 28.5 18 4720 230 48 400 2.47
LINC. VERSAILLES   A   13466 14 3 3 3.5 27.0 15 3830 201 41 302 2.47
MAZDA GLC          J    3995 30 4 4 3.5 25.5 11 1980 154 33  86 3.73
MERC. BOBCAT       A    3829 22 4 3 3.0 25.5  9 2580 169 39 140 2.73
MERC. COUGAR       A    5379 14 4 3 3.5 29.5 16 4060 221 48 302 2.75
MERC. COUGAR XR-7  A    6303 14 4 4 3.0 25.0 16 4130 217 45 302 2.75
MERC. MARQUIS      A    6165 15 3 2 3.5 30.5 23 3720 212 44 302 2.26
MERC. MONARCH      A    4516 18 3 . 3.0 27.0 15 3370 198 41 250 2.43
MERC. ZEPHYR       A    3291 20 3 3 3.5 29.0 17 2830 195 43 140 3.08
OLDS. 98           A    8814 21 4 4 4.0 31.5 20 4060 220 43 350 2.41
OLDS. CUTLASS      A    4733 19 3 3 4.5 28.0 16 3300 198 42 231 2.93
OLDS. CUTL SUPR    A    5172 19 3 4 2.0 28.0 16 3310 198 42 231 2.93
OLDS. DELTA 88     A    5890 18 4 4 4.0 29.0 20 3690 218 42 231 2.73
OLDS. OMEGA        A    4181 19 3 3 4.5 27.0 14 3370 200 43 231 3.08
OLDS. STARFIRE     A    4195 24 1 1 2.0 25.5 10 2720 180 40 151 2.73
OLDS. TORONADO     A   10371 16 3 3 3.5 30.0 17 4030 206 43 350 2.41
PEUGEOT 604 SL     E   12990 14 . . 3.5 30.5 14 3420 192 38 163 3.58
PLYM. ARROW        A    4647 28 3 3 2.0 21.5 11 2360 170 37 156 3.05
PLYM. CHAMP        A    4425 34 5 4 2.5 23.0 11 1800 157 37  86 2.97
PLYM. HORIZON      A    4482 25 3 . 4.0 25.0 17 2200 165 36 105 3.37
PLYM. SAPPORO      A    6486 26 . . 1.5 22.0  8 2520 182 38 119 3.54
PLYM. VOLARE       A    4060 18 2 2 5.0 31.0 16 3330 201 44 225 3.23
PONT. CATALINA     A    5798 18 4 4 4.0 29.0 20 3700 214 42 231 2.73
PONT. FIREBIRD     A    4934 18 1 2 1.5 23.5  7 3470 198 42 231 3.08
PONT. GRAND PRIX   A    5222 19 3 3 2.0 28.5 16 3210 201 45 231 2.93
PONT. LE MANS      A    4723 19 3 3 3.5 28.0 17 3200 199 40 231 2.93
PONT. PHOENIX      A    4424 19 . . 3.5 27.0 13 3420 203 43 231 3.08
PONT. SUNBIRD      A    4172 24 2 2 2.0 25.0  7 2690 179 41 151 2.73
RENAULT LE CAR     E    3895 26 3 3 3.0 23.0 10 1830 142 34  79 3.72
SUBARU             J    3798 35 5 4 2.5 25.5 11 2050 164 36  97 3.81
TOYOTA CELICA      J    5899 18 5 5 2.5 22.0 14 2410 174 36 134 3.06
TOYOTA COROLLA     J    3748 31 5 5 3.0 24.5  9 2200 165 35  97 3.21
TOYOTA CORONA      J    5719 18 5 5 2.0 23.0 11 2670 175 36 134 3.05
VW RABBIT          E    4697 25 4 3 3.0 25.5 15 1930 155 35  89 3.78
VW RABBIT DIESEL   E    5397 41 5 4 3.0 25.5 15 2040 155 35  90 3.78
VW SCIROCCO        E    6850 25 4 3 2.0 23.5 16 1990 156 36  97 3.78
VW DASHER          E    7140 23 4 3 2.5 37.5 12 2160 172 36  97 3.74
VOLVO 260          E   11995 17 5 3 2.5 29.5 14 3170 193 37 163 2.98
;



/* The BASEBALL Data Set: Baseball Data */

/* The BASEBALL data set contains variables that measure batting
   and fielding performance for 322 regular and substitute hitters
   in the 1986 year, their career performance statistics, and
   their salary at the start of the 1987 season.

 NAME:     hitter's name
 ATBAT:    times at bat
 HITS:     hits
 HOMER:    home runs
 RUNS:     runs
 RBI:      runs batted in
 WALKS:    walks
 YEARS:    years in the major leagues
 ATBATC:   career times at bat
 HITSC:    career hits
 HOMERC:   career home runs
 RUNSC:    career runs scored
 RBIC:     career runs batted in
 POSITION: player's position
 PUTOUTS:  put outs
 ASSISTS:  assists
 ERRORS:   errors
 SALARY:   annual salary, expressed in units of $1,000
 BATAVG:   batting average, calculated as 1,000*(HITS/ATBAT)
 BATAVGC:  career batting average, calculated as 1,000*(HITSC/ATBATC)
*/

Title 'Baseball Hitters Data';

 /* Formats to specify the coding of some of the variables */
proc format;
   value $league
     'N' ='National'
     'A' ='American';
   value $team
     'ATL'='Atlanta      '
     'BAL'='Baltimore    '
     'BOS'='Boston       '
     'CAL'='California   '
     'CHA'='Chicago A    '
     'CHN'='Chicago N    '
     'CIN'='Cincinnati   '
     'CLE'='Cleveland    '
     'DET'='Detroit      '
     'HOU'='Houston      '
     'KC '='Kansas City  '
     'LA '='Los Angeles  '
     'MIL'='Milwaukee    '
     'MIN'='Minnesota    '
     'MON'='Montreal     '
     'NYA'='New York A   '
     'NYN'='New York N   '
     'OAK'='Oakland      '
     'PHI'='Philadelphia '
     'PIT'='Pittsburgh   '
     'SD '='San Diego    '
     'SEA'='Seattle      '
     'SF '='San Francisco'
     'STL'='St. Louis    '
     'TEX'='Texas        '
     'TOR'='Toronto      ';
   value $posfmt
     '1B' = 'First Base'
     '2B' = 'Second Base'
     'SS' = 'Short Stop'
     '3B' = 'Third Base'
     'RF' = 'Right Field'
     'CF' = 'Center Field'
     'LF' = 'Left Field'
     'C ' = 'Catcher'
     'DH' = 'Designated Hitter'
     'OF' = 'Outfield'
     'UT' = 'Utility'
     'OS' = 'Outfield & Short Stop'
     '3S' = 'Third Base & Short Stop'
     '13' = 'First & Third Base'
     '3O' = 'Third Base & Outfield'
     'O1' = 'Outfield & First Base'
     'S3' = 'Short Stop & Third Base'
     '32' = 'Third & Second Base'
     'DO' = 'Designated Hitter & Outfield'
     'OD' = 'Outfield & Designated Hitter'
     'CD' = 'Catcher & Designated Hitter'
     'CS' = 'Catcher & Short Stop'
     '23' = 'Second & Third Base'
     '1O' = 'First Base and Outfield'
     '2S' = 'Second Base and Short Stop';
   /* Recode position to short list */
   value $pos
     'CS','CD'       ='C '
     'OS','O1','OD'  ='OF'
     'CF','RF','LF'  ='OF'
     '1O','13'       ='1B'
     '2S','23'       ='2B'
     'DO'            ='DH'
     'S3'            ='SS'
     '32','3S','3O'  ='3B' ;

data baseball;
   input name $1-14
         league $15 team $16-18 position $19-20
         atbat  3. hits  3. homer  3. runs  3. rbi  3. walks  3. years 3.
         atbatc 5. hitsc 4. homerc 4. runsc 4. rbic 4. walksc 4.
         putouts 4. assists 3. errors 3. salary 4.;
   batavg = round(1000 * (hits / atbat));
   batavgc= round(1000 * (hitsc/ atbatc));
   label
      name    = "Hitter's name"
      atbat   = 'Times at Bat'
      hits    = 'Hits'
      homer   = 'Home Runs'
      runs    = 'Runs'
      rbi     = 'Runs Batted In'
      walks   = 'Walks'
      years   = 'Years in the Major Leagues'
      atbatc  = 'Career Times at Bat'
      hitsc   = 'Career Hits'
      homerc  = 'Career Home Runs'
      runsc   = 'Career Runs Scored'
      rbic    = 'Career Runs Batted In'
      position= 'Position(s)'
      putouts = 'Put Outs'
      assists = 'Assists'
      errors  = 'Errors'
      salary  = 'Salary (in 1000$)'
      batavg  = 'Batting Average'
      batavgc = 'Career Batting Average';
 cards;
Andy Allanson ACLEC 293 66  1 30 29 14  1  293  66   1  30  29  14 446 33 20   .
Alan Ashby    NHOUC 315 81  7 24 38 39 14 3449 835  69 321 414 375 632 43 10 475
Alvin Davis   ASEA1B479130 18 66 72 76  3 1624 457  63 224 266 263 880 82 14 480
Andre Dawson  NMONRF496141 20 65 78 37 11 56281575 225 828 838 354 200 11  3 500
A Galarraga   NMON1B321 87 10 39 42 30  2  396 101  12  48  46  33 805 40  4  92
A Griffin     AOAKSS594169  4 74 51 35 11 44081133  19 501 336 194 282421 25 750
Al Newman     NMON2B185 37  1 23  8 21  2  214  42   1  30   9  24  76127  7  70
A Salazar     AKC SS298 73  0 24 24  7  3  509 108   0  41  37  12 121283  9 100
Andres Thomas NATLSS323 81  6 26 32  8  2  341  86   6  32  34   8 143290 19  75
A Thornton    ACLEDH401 92 17 49 66 65 13 52061332 253 784 890 866   0  0  01100
Alan Trammell ADETSS574159 21107 75 59 10 46311300  90 702 504 488 238445 22 517
Alex Trevino  NLA C 202 53  4 31 26 27  9 1876 467  15 192 186 161 304 45 11 513
A Van.Slyke   NSTLRF418113 13 48 61 47  4 1512 392  41 205 204 203 211 11  7 550
Alan Wiggins  ABAL2B239 60  0 30 11 22  6 1941 510   4 309 103 207 121151  6 700
Bill Almon    NPITUT196 43  7 29 27 30 13 3231 825  36 376 290 238  80 45  8 240
Billy Beane   AMINOF183 39  3 20 15 11  3  201  42   3  20  16  11 118  0  0   .
Buddy Bell    NCIN3B568158 20 89 75 73 15 80682273 1771045 993 732 105290 10 775
B Biancalana  AKC SS190 46  2 24  8 15  5  479 102   5  65  23  39 102177 16 175
Bruce Bochte  AOAK1B407104  6 57 43 65 12 52331478 100 643 658 653 912 88  9   .
Bruce Bochy   NSD C 127 32  8 16 22 14  8  727 180  24  67  82  56 202 22  2 135
Barry Bonds   NPITCF413 92 16 72 48 65  1  413  92  16  72  48  65 280  9  5 100
Bobby Bonilla ACHAO1426109  3 55 43 62  1  426 109   3  55  43  62 361 22  2 115
Bob Boone     ACALC  22 10  1  4  2  1  6   84  26   2   9   9   3 812 84 11   .
Bob Brenly    NSF C 472116 16 60 62 74  6 1924 489  67 242 251 240 518 55  3 600
Bill Buckner  ABOS1B629168 18 73102 40 18 84242464 16410081072 4021067157 14 777
Brett Butler  ACLECF587163  4 92 51 70  6 2695 747  17 442 198 317 434  9  3 765
Bob Dernier   NCHNCF324 73  4 32 18 22  7 1931 491  13 291 108 180 222  3  3 708
Bo Diaz       NCINC 474129 10 50 56 40 10 2331 604  61 246 327 166 732 83 13 750
Bill Doran    NHOU2B550152  6 92 37 81  5 2308 633  32 349 182 308 262329 16 625
Brian Downing ACALLF513137 20 90 95 90 14 52011382 166 763 734 784 267  5  3 900
Bobby Grich   ACAL2B313 84  9 42 30 39 17 68901833 2241033 8641087 127221  7   .
Billy Hatcher NHOUCF419108  6 55 36 22  3  591 149   8  80  46  31 226  7  4 110
Bob Horner    NATL1B517141 27 70 87 52  9 3571 994 215 545 652 3371378102  8   .
Brook Jacoby  ACLE3B583168 17 83 80 56  5 1646 452  44 219 208 136 109292 25 613
Bob Kearney   ASEAC 204 49  6 23 25 12  7 1309 308  27 126 132  66 419 46  5 300
Bill Madlock  NLA 3B379106 10 38 60 30 14 62071906 146 859 803 571  72170 24 850
Bobby Meacham ANYASS161 36  0 19 10 17  4 1053 244   3 156  86 107  70149 12   .
Bob Melvin    NSF C 268 60  5 24 25 15  2  350  78   5  34  29  18 442 59  6  90
Ben Oglivie   AMILDH346 98  5 31 53 30 16 59131615 235 784 901 560   0  0  0   .
Bip Roberts   NSD 2B241 61  1 34 12 14  1  241  61   1  34  12  14 166172 10   .
B Robidoux    AMIL1B181 41  1 15 21 33  2  232  50   4  20  29  45 326 29  5  68
Bill Russell  NLA UT216 54  0 21 18 15 18 73181926  46 796 627 483 103 84  5   .
Billy Sample  NATLOF200 57  6 23 14 14  9 2516 684  46 371 230 195  69  1  1   .
B Schroeder   AMILUT217 46  7 32 19  9  4  694 160  32  86  76  32 307 25  1 180
Butch Wynegar ANYAC 194 40  7 19 29 30 11 41831069  64 486 493 608 325 22  2   .
Chris Bando   ACLEC 254 68  2 28 26 22  6  999 236  21 108 117 118 359 30  4 305
Chris Brown   NSF 3B416132  7 57 49 33  3  932 273  24 113 121  80  73177 18 215
C Castillo    ACLEOD205 57  8 34 32  9  5  756 192  32 117 107  51  58  4  4 248
Cecil Cooper  AMIL1B542140 12 46 75 41 16 70992130 235 9871089 431 697 61  9   .
Chili Davis   NSF RF526146 13 71 70 84  6 2648 715  77 352 342 289 303  9  9 815
Carlton Fisk  ACHAC 457101 14 42 63 22 17 65211767 2811003 977 619 389 39  4 875
Curt Ford     NSTLOF214 53  2 30 29 23  2  226  59   2  32  32  27 109  7  3  70
Cliff Johnson ATORDH 19  7  0  1  2  1  4   41  13   1   3   4   4   0  0  0   .
C Lansford    AOAK3B591168 19 80 72 39  9 44781307 113 634 563 319  67147  41200
Chet Lemon    ADETCF403101 12 45 53 39 12 51501429 166 747 666 526 316  6  5 675
C Maldonado   NSF OF405102 18 49 85 20  6  950 231  29  99 138  64 161 10  3 415
C Martinez    NSD O1244 58  9 28 25 35  4 1335 333  49 164 179 194 142 14  2 340
Charlie Moore AMILC 235 61  3 24 39 21 14 39261029  35 441 401 333 425 43  4   .
C Reynolds    NHOUSS313 78  6 32 41 12 12 3742 968  35 409 321 170 106206  7 417
Cal Ripken    ABALSS627177 25 98 81 70  6 3210 927 133 529 472 313 240482 131350
Cory Snyder   ACLEOS416113 24 58 69 16  1  416 113  24  58  69  16 203 70 10  90
Chris Speier  NCHN3S155 44  6 21 23 15 16 66311634  98 698 661 777  53 88  3 275
C Wilkerson   ATEX2S236 56  0 27 15 11  4 1115 270   1 116  64  57 125199 13 230
Dave Anderson NLA 3S216 53  1 31 15 22  4  926 210   9 118  69 114  73152 11 225
Doug Baker    AOAKOF 24  3  0  1  0  2  3  159  28   0  20  12   9  80  4  0   .
Don Baylor    ABOSDH585139 31 93 94 62 17 75461982 31511411179 727   0  0  0 950
D Bilardello  NMONC 191 37  4 12 17 14  4  773 163  16  61  74  52 391 38  8   .
Daryl Boston  ACHACF199 53  5 29 22 21  3  514 120   8  57  40  39 152  3  5  75
Darnell Coles ADET3B521142 20 67 86 45  4  815 205  22  99 103  78 107242 23 105
Dave Collins  ADETLF419113  1 44 27 44 12 44841231  32 612 344 422 211  2  1   .
D Concepcion  NCINUT311 81  3 42 30 26 17 82472198 100 950 909 690 153223 10 320
D Daulton     NPHIC 138 31  8 18 21 38  3  244  53  12  33  32  55 244 21  4   .
Doug DeCinces ACAL3B512131 26 69 96 52 14 53471397 221 712 815 548 119216 12 850
Darrell Evans ADET1B507122 29 78 85 91 18 77611947 347117511521380 808108  2 535
Dwight Evans  ABOSRF529137 26 86 97 97 15 66611785 2911082 949 989 280 10  5 933
Damaso Garcia ATOR2B424119  6 57 46 13  9 36511046  32 461 301 112 224286  8 850
Dan Gladden   NSF CF351 97  4 55 29 39  4 1258 353  16 196 110 117 226  7  3 210
Danny Heep    NNYNOF195 55  5 24 33 30  8 1313 338  25 144 149 153  83  2  1   .
D Henderson   ASEAOF388103 15 59 47 39  6 2174 555  80 285 274 186 182  9  4 325
Donnie Hill   AOAK23339 96  4 37 29 23  4 1064 290  11 123 108  55 104213  9 275
Dave Kingman  AOAKDH561118 35 70 94 33 16 66771575 442 9011210 608 463 32  8   .
Davey Lopes   NCHN3O255 70  7 49 35 43 15 63111661 1541019 608 820  51 54  8 450
Don Mattingly ANYA1B677238 31117113 53  5 2223 737  93 349 401 1711377100  61975
Darryl Motley AKC RF227 46  7 23 20 12  5 1325 324  44 156 158  67  92  2  2   .
Dale Murphy   NATLCF614163 29 89 83 75 11 50171388 266 813 822 617 303  6  61900
Dwayne Murphy AOAKCF329 83  9 50 39 56  9 3828 948 145 575 528 635 276  6  2 600
Dave Parker   NCINRF637174 31 89116 56 14 67272024 247 9781093 495 278  9  91042
Dan Pasqua    ANYALF280 82 16 44 45 47  2  428 113  25  61  70  63 148  4  2 110
D Porter      ATEXCD155 41 12 21 29 22 16 54091338 181 746 805 875 165  9  1 260
D Schofield   ACALSS458114 13 67 57 48  4 1350 298  28 160 123 122 246389 18 475
Don Slaught   ATEXC 314 83 13 39 46 16  5 1457 405  28 156 159  76 533 40  4 432
D Strawberry  NNYNRF475123 27 76 93 72  4 1810 471 108 292 343 267 226 10  61220
Dale Sveum    AMIL3B317 78  7 35 35 32  1  317  78   7  35  35  32  45122 26  70
D Tartabull   ASEARF511138 25 76 96 61  3  592 164  28  87 110  71 157  7  8 145
Dickie Thon   NHOUSS278 69  3 24 21 29  8 2079 565  32 258 192 162 142210 10   .
Denny Walling NHOU3B382119 13 54 58 36 12 2133 594  41 287 294 227  59156  9 595
Dave Winfield ANYARF565148 24 90104 77 14 72872083 30511351234 791 292  9  51861
Enos Cabell   NLA 1B277 71  2 27 29 14 15 59521647  60 753 596 259 360 32  5   .
Eric Davis    NCINLF415115 27 97 71 68  3  711 184  45 156 119  99 274  2  7 300
Eddie Milner  NCINCF424110 15 70 47 36  7 2130 544  38 335 174 258 292  6  3 490
Eddie Murray  ABAL1B495151 17 61 84 78 10 56241679 275 8841015 7091045 88 132460
Ernest Riles  AMILSS524132  9 69 47 54  2  972 260  14 123  92  90 212327 20   .
Ed Romero     ABOSSS233 49  2 41 23 18  8 1350 336   7 166 122 106 102132 10 375
Ernie Whitt   ATORC 395106 16 48 56 35 10 2303 571  86 266 323 248 709 41  7   .
Fred Lynn     ABALCF397114 23 67 67 53 13 55891632 241 906 926 716 244  2  4   .
Floyd Rayford ABAL3B210 37  8 15 19 15  6  994 244  36 107 114  53  40115 15   .
F Stubbs      NLA LF420 95 23 55 58 37  3  646 139  31  77  77  61 206 10  7   .
Frank White   AKC 2B566154 22 76 84 43 14 61001583 131 743 693 300 316439 10 750
George Bell   ATORLF641198 31101108 41  5 2129 610  92 297 319 117 269 17 101175
Glenn Braggs  AMILLF215 51  4 19 18 11  1  215  51   4  19  18  11 116  5 12  70
George Brett  AKC 3B441128 16 70 73 80 14 66752095 20910721050 695  97218 161500
Greg Brock    NLA 1B325 76 16 33 52 37  5 1506 351  71 195 219 214 726 87  3 385
Gary Carter   NNYNC 490125 24 81105 62 13 60631646 271 847 999 680 869 62  81926
Glenn Davis   NHOU1B574152 31 91101 64  3  985 260  53 148 173  951253111 11 215
George Foster NNYNLF284 64 14 30 42 24 18 70231925 348 9861239 666  96  4  4   .
Gary Gaetti   AMIN3B596171 34 91108 52  6 2862 728 107 361 401 224 118334 21 900
Greg Gagne    AMINSS472118 12 63 54 30  4  793 187  14 102  80  50 228377 26 155
G Hendrick    ACALOF283 77 14 45 47 26 16 68401910 259 9151067 546 144  6  5 700
Glenn Hubbard NATL2B408 94  4 42 36 66  9 3573 866  59 429 365 410 282487 19 535
Garth Iorg    ATOR32327 85  3 30 44 20  8 2140 568  16 216 208  93  91185 12 363
Gary Matthews NCHNLF370 96 21 49 46 60 15 69861972 2311070 955 921 137  5  9 733
Graig Nettles NSD 3B354 77 16 36 55 41 20 87162172 384117212671057  83174 16 200
Gary Pettis   ACALCF539139  5 93 58 69  5 1469 369  12 247 126 198 462  9  7 400
Gary Redus    NPHILF340 84 11 62 33 47  5 1516 376  42 284 141 219 185  8  4 400
G Templeton   NSD SS510126  2 42 44 35 11 55621578  44 703 519 256 207358 20 738
Gorman Thomas ASEADH315 59 16 45 36 58 13 46771051 268 681 782 697   0  0  0   .
Greg Walker   ACHA1B282 78 13 37 51 29  5 1649 453  73 211 280 138 670 57  5 500
Gary Ward     ATEXLF380120  5 54 51 31  8 3118 900  92 444 419 240 237  8  1 600
Glenn Wilson  NPHIRF584158 15 70 84 42  5 2358 636  58 265 316 134 331 20  4 663
Harold Baines ACHARF570169 21 72 88 38  7 37541077 140 492 589 263 295 15  5 950
Hubie Brooks  NMONSS306104 14 50 58 25  7 2954 822  55 313 377 187 116222 15 750
H Johnson     NNYN3S220 54 10 30 39 31  5 1185 299  40 145 154 128  50136 20 298
Hal McRae     AKC DH278 70  7 22 37 18 18 71862081 190 9351088 643   0  0  0 325
H Reynolds    ASEA2B445 99  1 46 24 29  4  618 129   1  72  31  48 278415 16  88
Harry Spilman NSF 1B143 39  5 18 30 15  9  639 151  16  80  97  61 138 15  1 175
H Winningham  NMONOF185 40  4 23 11 18  3  524 125   7  58  37  47  97  2  2  90
J Barfield    ATORRF589170 40107108 69  6 2325 634 128 371 376 238 368 20  31238
Juan Beniquez ABALUT343103  6 48 36 40 15 43381193  70 581 421 325 211 56 13 430
Juan Bonilla  ABAL2B284 69  1 33 18 25  5 1407 361   6 139  98 111 122140  5   .
J Cangelosi   ACHALF438103  2 65 32 71  2  440 103   2  67  32  71 276  7  9 100
Jose Canseco  AOAKLF600144 33 85117 65  2  696 173  38 101 130  69 319  4 14 165
Joe Carter    ACLERF663200 29108121 32  4 1447 404  57 210 222  68 241  8  6 250
Jack Clark    NSTL1B232 55  9 34 23 45 12 44051213 194 702 705 625 623 35  31300
Jose Cruz     NHOULF479133 10 48 72 55 17 74722147 153 9801032 854 237  5  4 773
Julio Cruz    ACHA2B209 45  0 38 19 42 10 3859 916  23 557 279 478 132205  5   .
Jody Davis    NCHNC 528132 21 61 74 41  6 2641 671  97 273 383 226 885105  81008
Jim Dwyer     ABALDO160 39  8 18 31 22 14 2128 543  56 304 268 298  33  3  0 275
Julio Franco  ACLESS599183 10 80 74 32  5 2482 715  27 330 326 158 231374 18 775
Jim Gantner   AMIL2B497136  7 58 38 26 11 38711066  40 450 367 241 304347 10 850
Johnny Grubb  ADETDH210 70 13 32 51 28 15 40401130  97 544 462 551   0  0  0 365
J Hairston    ACHAUT225 61  5 32 26 26 11 1568 408  25 202 185 257 132  9  0   .
Jack Howell   ACAL3B151 41  4 26 21 19  2  288  68   9  45  39  35  28 56  2  95
John Kruk     NSD LF278 86  4 33 38 45  1  278  86   4  33  38  45 102  4  2 110
J Leonard     NSF LF341 95  6 48 42 20 10 2964 808  81 379 428 221 158  4  5 100
Jim Morrison  NPIT3B537147 23 58 88 47 10 2744 730  97 302 351 174  92257 20 278
John Moses    ASEACF399102  3 56 34 34  5  670 167   4  89  48  54 211  9  3  80
J Mumphrey    NCHNOF309 94  5 37 32 26 13 46181330  57 616 522 436 161  3  3 600
Joe Orsulak   NPITRF401100  2 60 19 28  4  876 238   2 126  44  55 193 11  4   .
Jorge Orta    AKC DH336 93  9 35 46 23 15 57791610 128 730 741 497   0  0  0   .
Jim Presley   ASEA3B616163 27 83107 32  3 1437 377  65 181 227  82 110308 15 200
Jamie Quirk   AKC CS219 47  8 24 26 17 12 1188 286  23 100 125  63 260 58  4   .
Johnny Ray    NPIT2B579174  7 67 78 58  6 3053 880  32 366 337 218 280479  5 657
Jeff Reed     AMINC 165 39  2 13  9 16  3  196  44   2  18  10  18 332 19  2  75
Jim Rice      ABOSLF618200 20 98110 62 13 71272163 35111041289 564 330 16  82413
Jerry Royster NSD UT257 66  5 31 26 32 14 3910 979  33 518 324 382  87166 14 250
John Russell  NPHIC 315 76 13 35 60 25  3  630 151  24  68  94  55 498 39 13 155
Juan Samuel   NPHI2B591157 16 90 78 26  4 2020 541  52 310 226  91 290440 25 640
John Shelby   ABALOF404 92 11 54 49 18  6 1354 325  30 188 135  63 222  5  5 300
Joel Skinner  ACHAC 315 73  5 23 37 16  4  450 108   6  38  46  28 227 15  3 110
Jeff Stone    NPHIOF249 69  6 32 19 20  4  702 209  10  97  48  44 103  8  2   .
Jim Sundberg  AKC C 429 91 12 41 42 57 13 55901397  83 578 579 644 686 46  4 825
Jim Traber    ABALUT212 54 13 28 44 18  2  233  59  13  31  46  20 243 23  5   .
Jose Uribe    NSF SS453101  3 46 43 61  3  948 218   6  96  72  91 249444 16 195
Jerry Willard AOAKC 161 43  4 17 26 22  3  707 179  21  77  99  76 300 12  2   .
J Youngblood  NSF OF184 47  5 20 28 18 11 3327 890  74 419 382 304  49  2  0 450
Kevin Bass    NHOURF591184 20 83 79 38  5 1689 462  40 219 195  82 303 12  5 630
Kal Daniels   NCINOF181 58  6 34 23 22  1  181  58   6  34  23  22  88  0  3  87
Kirk Gibson   ADETRF441118 28 84 86 68  8 2723 750 126 433 420 309 190  2  21300
Ken Griffey   ANYAOF490150 21 69 58 35 14 61261839 121 983 707 600  96  5  31000
K Hernandez   NNYN1B551171 13 94 83 94 13 60901840 128 969 900 9171199149  51800
Kent Hrbek    AMIN1B550147 29 85 91 71  6 2816 815 117 405 474 3191218104 101310
Ken Landreaux NLA OF283 74  4 34 29 22 10 39191062  85 505 456 283 145  5  7 738
K McReynolds  NSD CF560161 26 89 96 66  4 1789 470  65 233 260 155 332  9  8 625
K Mitchell    NNYNOS328 91 12 51 43 33  2  342  94  12  51  44  33 145 59  8 125
K Moreland    NCHNRF586159 12 72 79 53  9 3082 880  83 363 477 295 181 13  41043
Ken Oberkfell NATL3B503136  5 62 48 83 10 3423 970  20 408 303 414  65258  8 725
Ken Phelps    ASEADH344 85 24 69 64 88  7  911 214  64 150 156 187   0  0  0 300
Kirby Puckett AMINCF680223 31119 96 34  3 1928 587  35 262 201  91 429  8  6 365
K Stillwell   NCINSS279 64  0 31 26 30  1  279  64   0  31  26  30 107205 16  75
Leon Durham   NCHN1B484127 20 66 65 67  7 3006 844 116 436 458 3771231 80  71183
Len Dykstra   NNYNCF431127  8 77 45 58  2  667 187   9 117  64  88 283  8  3 203
Larry Herndon ADETOF283 70  8 33 37 27 12 44791222  94 557 483 307 156  2  2 225
Lee Lacy      ABALRF491141 11 77 47 37 15 42911240  84 615 430 340 239  8  2 525
Len Matuszek  NLA O1199 52  9 26 28 21  6  805 191  30 113 119  87 235 22  5 265
Lloyd Moseby  ATORCF589149 21 89 86 64  7 3558 928 102 513 471 351 371  6  6 788
Lance Parrish ADETC 327 84 22 53 62 38 10 42731123 212 577 700 334 483 48  6 800
Larry Parrish ATEXDH464128 28 67 94 52 13 58291552 210 740 840 452   0  0  0 588
Luis Rivera   NMONSS166 34  0 20 13 17  1  166  34   0  20  13  17  64119  9   .
Larry Sheets  ABALDH338 92 18 42 60 21  3  682 185  36  88 112  50   0  0  0 145
Lonnie Smith  AKC LF508146  8 80 44 46  9 3148 915  41 571 289 326 245  5  9   .
Lou Whitaker  ADET2B584157 20 95 73 63 10 47041320  93 724 522 576 276421 11 420
Mike Aldrete  NSF 1O216 54  2 27 25 33  1  216  54   2  27  25  33 317 36  1  75
Marty Barrett ABOS2B625179  4 94 60 65  5 1696 476  12 216 163 166 303450 14 575
Mike Brown    NPITOF243 53  4 18 26 27  4  853 228  23 101 110  76 107  3  3   .
Mike Davis    AOAKRF489131 19 77 55 34  7 2051 549  62 300 263 153 310  9  9 780
Mike Diaz     NPITO1209 56 12 22 36 19  2  216  58  12  24  37  19 201  6  3  90
M Duncan      NLA SS407 93  8 47 30 30  2  969 230  14 121  69  68 172317 25 150
Mike Easler   ANYADH490148 14 64 78 49 13 34001000 113 445 491 301   0  0  0 700
M Fitzgerald  NMONC 209 59  6 20 37 27  4  884 209  14  66 106  92 415 35  3   .
Mel Hall      ACLELF442131 18 68 77 33  6 1416 398  47 210 203 136 233  7  7 550
M Hatcher     AMINUT317 88  3 40 32 19  8 2543 715  28 269 270 118 220 16  4   .
Mike Heath    NSTLC 288 65  8 30 36 27  9 2815 698  55 315 325 189 259 30 10 650
Mike Kingery  AKC OF209 54  3 25 14 12  1  209  54   3  25  14  12 102  6  3  68
M LaValliere  NSTLC 303 71  3 18 30 36  3  344  76   3  20  36  45 468 47  6 100
Mike Marshall NLA RF330 77 19 47 53 27  6 1928 516  90 247 288 161 149  8  6 670
M Pagliarulo  ANYA3B504120 28 71 71 54  3 1085 259  54 150 167 114 103283 19 175
Mark Salas    AMINC 258 60  8 28 33 18  3  638 170  17  80  75  36 358 32  8 137
Mike Schmidt  NPHI3B 20  1  0  0  0  0  2   41   9   2   6   7   4  78220  62127
Mike Scioscia NLA C 374 94  5 36 26 62  7 1968 519  26 181 199 288 756 64 15 875
M Tettleton   AOAKC 211 43 10 26 35 39  3  498 116  14  59  55  78 463 32  8 120
Milt Thompson NPHICF299 75  6 38 23 26  3  580 160   8  71  33  44 212  1  2 140
Mitch Webster NMONCF576167  8 89 49 57  4  822 232  19 132  83  79 325 12  8 210
Mookie Wilson NNYNOF381110  9 61 45 32  7 3015 834  40 451 249 168 228  7  5 800
Marvell Wynne NSD OF288 76  7 34 37 15  4 1644 408  16 198 120 113 203  3  3 240
Mike Young    ABALLF369 93  9 43 42 49  5 1258 323  54 181 177 157 149  1  6 350
Nick Esasky   NCIN1B330 76 12 35 41 47  4 1367 326  55 167 198 167 512 30  5   .
Ozzie Guillen ACHASS547137  2 58 47 12  2 1038 271   3 129  80  24 261459 22 175
O McDowell    ATEXCF572152 18105 49 65  2  978 249  36 168  91 101 325 13  3 200
Omar Moreno   NATLRF359 84  4 46 27 21 12 49921257  37 699 386 387 151  8  5   .
Ozzie Smith   NSTLSS514144  0 67 54 79  9 47391169  13 583 374 528 229453 151940
Ozzie Virgil  NATLC 359 80 15 45 48 63  7 1493 359  61 176 202 175 682 93 13 700
Phil Bradley  ASEALF526163 12 88 50 77  4 1556 470  38 245 167 174 250 11  1 750
Phil Garner   NHOU3B313 83  9 43 41 30 14 58851543 104 751 714 535  58141 23 450
P Incaviglia  ATEXRF540135 30 82 88 55  1  540 135  30  82  88  55 157  6 14 172
Paul Molitor  AMIL3B437123  9 62 55 40  9 41391203  79 676 390 364  82170 151260
Pete O'Brien  ATEX1B551160 23 86 90 87  5 2235 602  75 278 328 2731224115 11   .
Pete Rose     NCIN1B237 52  0 15 25 30 24140534256 160216513141566 523 43  6 750
Pat Sheridan  ADETOF236 56  6 41 19 21  5 1257 329  24 166 125 105 172  1  4 190
Pat Tabler    ACLE1B473154  6 61 48 29  6 1966 566  29 250 252 178 846 84  9 580
R Belliard    NPITSS309 72  0 33 31 26  5  354  82   0  41  32  26 117269 12 130
Rick Burleson ACALUT271 77  5 35 29 33 12 49331358  48 630 435 403  62 90  3 450
Randy Bush    AMINLF357 96  7 50 45 39  5 1394 344  43 178 192 136 167  2  4 300
Rick Cerone   AMILC 216 56  4 22 18 15 12 2796 665  43 266 304 198 391 44  4 250
Ron Cey       NCHN3B256 70 13 42 36 44 16 70581845 312 9651128 990  41118  81050
Rob Deer      AMILRF466108 33 75 86 72  3  652 142  44 102 109 102 286  8  8 215
Rick Dempsey  ABALC 327 68 13 42 29 45 18 3949 939  78 438 380 466 659 53  7 400
Rich Gedman   ABOSC 462119 16 49 65 37  7 2131 583  69 244 288 150 866 65  6   .
Ron Hassey    ANYAC 341110  9 45 49 46  9 2331 658  50 249 322 274 251  9  4 560
R Henderson   ANYACF608160 28130 74 89  8 40711182 103 862 417 708 426  4  61670
R Jackson     ACALDH419101 18 65 58 92 20 95282510 548150916591342   0  0  0 488
Ricky Jones   ACALRF 33  6  0  2  4  7  1   33   6   0   2   4   7 205  5  4   .
Ron Kittle    ACHADH376 82 21 42 60 35  5 1770 408 115 238 299 157   0  0  0 425
Ray Knight    NNYN3B486145 11 51 76 40 11 39671102  67 410 497 284  88204 16 500
Randy Kutcher NSF OF186 44  7 28 16 11  1  186  44   7  28  16  11  99  3  1   .
Rudy Law      AKC OF307 80  1 42 36 29  7 2421 656  18 379 198 184 145  2  2   .
Rick Leach    ATORDO246 76  5 35 39 13  6  912 234  12 102  96  80  44  0  1 250
Rick Manning  AMILOF205 52  8 31 27 17 12 51341323  56 643 445 459 155  3  2 400
R Mulliniks   ATOR3B348 90 11 50 45 43 10 2288 614  43 295 273 269  60176  6 450
Ron Oester    NCIN2B523135  8 52 44 52  9 3368 895  39 377 284 296 367475 19 750
Rey Quinones  ABOSSS312 68  2 32 22 24  1  312  68   2  32  22  24  86150 15  70
R Ramirez     NATLS3496119  8 57 33 21  7 3358 882  36 365 280 165 155371 29 875
Ronn Reynolds NPITLF126 27  3  8 10  5  4  239  49   3  16  13  14 190  2  9 190
Ron Roenicke  NPHIOF275 68  5 42 42 61  6  961 238  16 128 104 172 181  3  2 191
Ryne Sandberg NCHN2B627178 14 68 76 46  6 3146 902  74 494 345 242 309492  5 740
R Santana     NNYNSS394 86  1 38 28 36  4 1089 267   3  94  71  76 203369 16 250
Rick Schu     NPHI3B208 57  8 32 25 18  3  653 170  17  98  54  62  42 94 13 140
Ruben Sierra  ATEXOF382101 16 50 55 22  1  382 101  16  50  55  22 200  7  6  98
Roy Smalley   AMINDH459113 20 59 57 68 12 53481369 155 713 660 735   0  0  0 740
R Thompson    NSF 2B549149  7 73 47 42  1  549 149   7  73  47  42 255450 17 140
Rob Wilfong   ACAL2B288 63  3 25 33 16 10 2682 667  38 315 259 204 135257  7 342
R Williams    NLA CF303 84  4 35 32 23  2  312  87   4  39  32  23 179  5  3   .
Robin Yount   AMILCF522163  9 82 46 62 13 70372019 1531043 827 535 352  9  11000
Steve Balboni AKC 1B512117 29 54 88 43  6 1750 412 100 204 276 1551236 98 18 100
Scott Bradley ASEAC 220 66  5 20 28 13  3  290  80   5  27  31  15 281 21  3  90
Sid Bream     NPIT1B522140 16 73 77 60  4  730 185  22  93 106  861320166 17 200
S Buechele    ATEX3B461112 18 54 54 35  2  680 160  24  76  75  49 111226 11 135
S Dunston     NCHNSS581145 17 66 68 21  2  831 210  21 106  86  40 320465 32 155
S Fletcher    ATEXSS530159  3 82 50 47  6 1619 426  11 218 149 163 196354 15 475
Steve Garvey  NSD 1B557142 21 58 81 23 18 87592583 27111381299 4781160 53  71450
Steve Jeltz   NPHISS439 96  0 44 36 65  4  711 148   1  68  56  99 229406 22 150
S Lombardozzi AMIN2B453103  8 53 33 52  2  507 123   8  63  39  58 289407  6 105
Spike Owen    ASEASS528122  1 67 45 51  4 1716 403  12 211 146 155 209372 17 350
Steve Sax     NLA 2B633210  6 91 56 59  6 3070 872  19 420 230 274 367432 16  90
Tony Armas    ABOSCF 16  2  0  1  0  0  2   28   4   0   1   0   0 247  4  8   .
T Bernazard   ACLE2B562169 17 88 73 53  8 3181 841  61 450 342 373 351442 17 530
Tom Brookens  ADETUT281 76  3 42 25 20  8 2658 657  48 324 300 179 106144  7 342
Tom Brunansky AMINRF593152 23 69 75 53  6 2765 686 133 369 384 321 315 10  6 940
T Fernandez   ATORSS687213 10 91 65 27  4 1518 448  15 196 137  89 294445 13 350
Tim Flannery  NSD 2B368103  3 48 28 54  8 1897 493   9 207 162 198 209246  3 327
Tom Foley     NMONUT263 70  1 26 23 30  4  888 220   9  83  82  86  81147  4 250
Tony Gwynn    NSD RF642211 14107 59 52  5 2364 770  27 352 230 193 337 19  4 740
Terry Harper  NATLOF265 68  8 26 30 29  7 1337 339  32 135 163 128  92  5  3 425
Toby Harrah   ATEX2B289 63  7 36 41 44 17 74021954 1951115 9191153 166211  7   .
Tommy Herr    NSTL2B559141  2 48 61 73  8 3162 874  16 421 349 359 352414  9 925
Tim Hulett    ACHA3B520120 17 53 44 21  4  927 227  22 106  80  52  70144 11 185
Terry Kennedy NSD C  19  4  1  2  3  1  1   19   4   1   2   3   1 692 70  8 920
Tito Landrum  NSTLOF205 43  2 24 17 20  7  854 219  12 105  99  71 131  6  1 287
Tim Laudner   AMINC 193 47 10 21 29 24  6 1136 256  42 129 139 106 299 13  5 245
Tom O'Malley  ABAL3B181 46  1 19 18 17  5  937 238   9  88  95 104  37 98  9   .
Tom Paciorek  ATEXUT213 61  4 17 22  3 17 40611145  83 488 491 244 178 45  4 235
Tony Pena     NPITC 510147 10 56 52 53  7 2872 821  63 307 340 174 810 99 181150
T Pendleton   NSTL3B578138  1 56 59 34  3 1399 357   7 149 161  87 133371 20 160
Tony Perez    NCIN1B200 51  2 14 29 25 23 97782732 37912721652 925 398 29  7   .
Tony Phillips AOAK2B441113  5 76 52 76  5 1546 397  17 226 149 191 160290 11 425
Terry Puhl    NHOUOF172 42  3 17 14 15 10 40861150  57 579 363 406  65  0  0 900
Tim Raines    NMONLF580194  9 91 62 78  8 33721028  48 604 314 469 270 13  6   .
Ted Simmons   NATLUT127 32  4 14 25 12 19 83962402 24210481348 819 167 18  6 500
Tim Teufel    NNYN2B279 69  4 35 31 32  4 1359 355  31 180 148 158 133173  9 278
Tim Wallach   NMON3B480112 18 50 71 44  7 3031 771 110 338 406 239  94270 16 750
Vince Coleman NSTLLF600139  0 94 29 60  2 1236 309   1 201  69 110 300 12  9 160
Von Hayes     NPHI1B610186 19107 98 74  6 2728 753  69 399 366 2861182 96 131300
Vance Law     NMON2B360 81  5 37 44 37  7 2268 566  41 279 257 246 170284  3 525
Wally Backman NNYN2B387124  1 67 27 36  7 1775 506   6 272 125 194 186290 17 550
Wade Boggs    ABOS3B580207  8107 71105  5 2778 978  32 474 322 417 121267 191600
Will Clark    NSF 1B408117 11 66 41 34  1  408 117  11  66  41  34 942 72 11 120
Wally Joyner  ACAL1B593172 22 82100 57  1  593 172  22  82 100  571222139 15 165
W Krenchicki  NMON13221 53  2 21 23 22  8 1063 283  15 107 124 106 325 58  6   .
Willie McGee  NSTLCF497127  7 65 48 37  5 2703 806  32 379 311 138 325  9  3 700
W Randolph    ANYA2B492136  5 76 50 94 12 55111511  39 897 451 875 313381 20 875
W Tolleson    ACHA3B475126  3 61 43 52  6 1700 433   7 217  93 146  37113  7 385
Willie Upshaw ATOR1B573144  9 85 60 78  8 3198 857  97 470 420 3321314131 12 960
Willie Wilson AKC CF631170  9 77 44 31 11 49081457  30 775 357 249 408  4  31000
;



/* The CITYTEMP Data Set: City Temperatures Data */

/* The data set CITYTEMP contains the mean monthly temperature
   in January and July in 64 selected North American cities.
   The city names are listed in full in the variable CITY and
   abbreviated to the first three letters in the variable CTY.
*/

title 'Mean temperature in January and July for selected cities';
data citytemp;
   input cty $1-3 city $1-15 january july;
cards;
MOBILE          51.2 81.6
PHOENIX         51.2 91.2
LITTLE ROCK     39.5 81.4
SACRAMENTO      45.1 75.2
DENVER          29.9 73.0
HARTFORD        24.8 72.7
WILMINGTON      32.0 75.8
WASHINGTON DC   35.6 78.7
JACKSONVILLE    54.6 81.0
MIAMI           67.2 82.3
ATLANTA         42.4 78.0
BOISE           29.0 74.5
CHICAGO         22.9 71.9
PEORIA          23.8 75.1
INDIANAPOLIS    27.9 75.0
DES MOINES      19.4 75.1
WICHITA         31.3 80.7
LOUISVILLE      33.3 76.9
NEW ORLEANS     52.9 81.9
PORTLAND, MAINE 21.5 68.0
BALTIMORE       33.4 76.6
BOSTON          29.2 73.3
DETROIT         25.5 73.3
SAULT STE MARIE 14.2 63.8
DULUTH           8.5 65.6
MINNEAPOLIS     12.2 71.9
JACKSON         47.1 81.7
KANSAS CITY     27.8 78.8
ST LOUIS        31.3 78.6
GREAT FALLS     20.5 69.3
OMAHA           22.6 77.2
RENO            31.9 69.3
CONCORD         20.6 69.7
ATLANTIC CITY   32.7 75.1
ALBUQUERQUE     35.2 78.7
ALBANY          21.5 72.0
BUFFALO         23.7 70.1
NEW YORK        32.2 76.6
CHARLOTTE       42.1 78.5
RALEIGH         40.5 77.5
BISMARCK         8.2 70.8
CINCINNATI      31.1 75.6
CLEVELAND       26.9 71.4
COLUMBUS        28.4 73.6
OKLAHOMA CITY   36.8 81.5
PORTLAND, OREG  38.1 67.1
PHILADELPHIA    32.3 76.8
PITTSBURGH      28.1 71.9
PROVIDENCE      28.4 72.1
COLUMBIA        45.4 81.2
SIOUX FALLS     14.2 73.3
MEMPHIS         40.5 79.6
NASHVILLE       38.3 79.6
DALLAS          44.8 84.8
EL PASO         43.6 82.3
HOUSTON         52.1 83.3
SALT LAKE CITY  28.0 76.7
BURLINGTON      16.8 69.8
NORFOLK         40.5 78.3
RICHMOND        37.5 77.9
SPOKANE         25.4 69.7
CHARLESTON, WV  34.5 75.0
MILWAUKEE       19.4 69.9
CHEYENNE        26.6 69.1
;



/* The CRIME Data Set: State Crime Data

   The data set CRIME contains the rates of occurrence
   (per 100,000 population) of seven types of crime in
   each of the 50 U.S. states.  The state names are listed
   in full in the variable STATE and abbreviated to standard
   two-letter codes in the variable ST.
*/

data crime;
   input state $1-15 murder rape robbery assault burglary larceny
         auto st $;
   cards;
ALABAMA        14.2 25.2  96.8 278.3 1135.5 1881.9 280.7   AL
ALASKA         10.8 51.6  96.8 284.0 1331.7 3369.8 753.3   AK
ARIZONA         9.5 34.2 138.2 312.3 2346.1 4467.4 439.5   AZ
ARKANSAS        8.8 27.6  83.2 203.4  972.6 1862.1 183.4   AR
CALIFORNIA     11.5 49.4 287.0 358.0 2139.4 3499.8 663.5   CA
COLORADO        6.3 42.0 170.7 292.9 1935.2 3903.2 477.1   CO
CONNECTICUT     4.2 16.8 129.5 131.8 1346.0 2620.7 593.2   CT
DELAWARE        6.0 24.9 157.0 194.2 1682.6 3678.4 467.0   DE
FLORIDA        10.2 39.6 187.9 449.1 1859.9 3840.5 351.4   FL
GEORGIA        11.7 31.1 140.5 256.5 1351.1 2170.2 297.9   GA
HAWAII          7.2 25.5 128.0  64.1 1911.5 3920.4 489.4   HI
IDAHO           5.5 19.4  39.6 172.5 1050.8 2599.6 237.6   ID
ILLINOIS        9.9 21.8 211.3 209.0 1085.0 2828.5 528.6   IL
INDIANA         7.4 26.5 123.2 153.5 1086.2 2498.7 377.4   IN
IOWA            2.3 10.6  41.2  89.8  812.5 2685.1 219.9   IA
KANSAS          6.6 22.0 100.7 180.5 1270.4 2739.3 244.3   KS
KENTUCKY       10.1 19.1  81.1 123.3  872.2 1662.1 245.4   KY
LOUISIANA      15.5 30.9 142.9 335.5 1165.5 2469.9 337.7   LA
MAINE           2.4 13.5  38.7 170.0 1253.1 2350.7 246.9   ME
MARYLAND        8.0 34.8 292.1 358.9 1400.0 3177.7 428.5   MD
MASSACHUSETTS   3.1 20.8 169.1 231.6 1532.2 2311.3 1140.1  MA
MICHIGAN        9.3 38.9 261.9 274.6 1522.7 3159.0 545.5   MI
MINNESOTA       2.7 19.5  85.9  85.8 1134.7 2559.3 343.1   MN
MISSISSIPPI    14.3 19.6  65.7 189.1  915.6 1239.9 144.4   MS
MISSOURI        9.6 28.3 189.0 233.5 1318.3 2424.2 378.4   MO
MONTANA         5.4 16.7  39.2 156.8  804.9 2773.2 309.2   MT
NEBRASKA        3.9 18.1  64.7 112.7  760.0 2316.1 249.1   NE
NEVADA         15.8 49.1 323.1 355.0 2453.1 4212.6 559.2   NV
NEW HAMPSHIRE   3.2 10.7  23.2  76.0 1041.7 2343.9 293.4   NH
NEW JERSEY      5.6 21.0 180.4 185.1 1435.8 2774.5 511.5   NJ
NEW MEXICO      8.8 39.1 109.6 343.4 1418.7 3008.6 259.5   NM
NEW YORK       10.7 29.4 472.6 319.1 1728.0 2782.0 745.8   NY
NORTH CAROLINA 10.6 17.0  61.3 318.3 1154.1 2037.8 192.1   NC
NORTH DAKOTA    0.9  9.0  13.3  43.8  446.1 1843.0 144.7   ND
OHIO            7.8 27.3 190.5 181.1 1216.0 2696.8 400.4   OH
OKLAHOMA        8.6 29.2  73.8 205.0 1288.2 2228.1 326.8   OK
OREGON          4.9 39.9 124.1 286.9 1636.4 3506.1 388.9   OR
PENNSYLVANIA    5.6 19.0 130.3 128.0  877.5 1624.1 333.2   PA
RHODE ISLAND    3.6 10.5  86.5 201.0 1489.5 2844.1 791.4   RI
SOUTH CAROLINA 11.9 33.0 105.9 485.3 1613.6 2342.4 245.1   SC
SOUTH DAKOTA    2.0 13.5  17.9 155.7  570.5 1704.4 147.5   SD
TENNESSEE      10.1 29.7 145.8 203.9 1259.7 1776.5 314.0   TN
TEXAS          13.3 33.8 152.4 208.2 1603.1 2988.7 397.6   TX
UTAH            3.5 20.3  68.8 147.3 1171.6 3004.6 334.5   UT
VERMONT         1.4 15.9  30.8 101.2 1348.2 2201.0 265.2   VT
VIRGINIA        9.0 23.3  92.1 165.7  986.2 2521.2 226.7   VA
WASHINGTON      4.3 39.6 106.2 224.8 1605.6 3386.9 360.3   WA
WEST VIRGINIA   6.0 13.2  42.2  90.9  597.4 1341.7 163.3   WV
WISCONSIN       2.8 12.9  52.2  63.7  846.9 2614.2 220.7   WI
WYOMING         5.4 21.9  39.7 173.9  811.6 2772.2 282.0   WY
;



/* The DIABETES Data Set: Diabetes Data

   Reaven and Miller (1979) examined the relationship among blood
   chemistry measures of glucose tolerance and insulin
   in 145 nonobese adults classified as subclinical (chemical)
   diabetics, overt diabetics, and normals.
   The data set DIABETES contains the following variables:

 PATIENT: patient number
 RELWT:   relative weight, expressed as a ratio of actual weight to
          expected weight, given the person's height
 GLUFAST: fasting plasma glucose
 GLUTEST: test plasma glucose, a measure of glucose intolerance
 SSPG:    steady state plasma glucose, a measure of insulin resistance
 INSTEST: plasma insulin during test, a measure of insulin response to
          oral glucose
 GROUP:   clinical group (1=overt diabetic, 2=chemical diabetic, 3=normal)
*/

title 'Diabetes Data';
proc format;
   value gp   1='Overt Diabetic ' 2='Chem. Diabetic' 3='Normal';
data diabetes;
   input patient relwt glufast glutest instest sspg group;
   label relwt   = 'Relative weight'
         glufast = 'Fasting Plasma Glucose'
         glutest = 'Test Plasma Glucose'
         sspg    = 'Steady State Plasma Glucose'
         instest = 'Plasma Insulin during Test'
         group   = 'Clinical Group';
cards;
   1  0.81  80  356 124   55  3
   2  0.95  97  289 117   76  3
   3  0.94 105  319 143  105  3
   4  1.04  90  356 199  108  3
   5  1.00  90  323 240  143  3
   6  0.76  86  381 157  165  3
   7  0.91 100  350 221  119  3
   8  1.10  85  301 186  105  3
   9  0.99  97  379 142   98  3
  10  0.78  97  296 131   94  3
  11  0.90  91  353 221   53  3
  12  0.73  87  306 178   66  3
  13  0.96  78  290 136  142  3
  14  0.84  90  371 200   93  3
  15  0.74  86  312 208   68  3
  16  0.98  80  393 202  102  3
  17  1.10  90  364 152   76  3
  18  0.85  99  359 185   37  3
  19  0.83  85  296 116   60  3
  20  0.93  90  345 123   50  3
  21  0.95  90  378 136   47  3
  22  0.74  88  304 134   50  3
  23  0.95  95  347 184   91  3
  24  0.97  90  327 192  124  3
  25  0.72  92  386 279   74  3
  26  1.11  74  365 228  235  3
  27  1.20  98  365 145  158  3
  28  1.13 100  352 172  140  3
  29  1.00  86  325 179  145  3
  30  0.78  98  321 222   99  3
  31  1.00  70  360 134   90  3
  32  1.00  99  336 143  105  3
  33  0.71  75  352 169   32  3
  34  0.76  90  353 263  165  3
  35  0.89  85  373 174   78  3
  36  0.88  99  376 134   80  3
  37  1.17 100  367 182   54  3
  38  0.85  78  335 241  175  3
  39  0.97 106  396 128   80  3
  40  1.00  98  277 222  186  3
  41  1.00 102  378 165  117  3
  42  0.89  90  360 282  160  3
  43  0.98  94  291  94   71  3
  44  0.78  80  269 121   29  3
  45  0.74  93  318  73   42  3
  46  0.91  86  328 106   56  3
  47  0.95  85  334 118  122  3
  48  0.95  96  356 112   73  3
  49  1.03  88  291 157  122  3
  50  0.87  87  360 292  128  3
  51  0.87  94  313 200  233  3
  52  1.17  93  306 220  132  3
  53  0.83  86  319 144  138  3
  54  0.82  86  349 109   83  3
  55  0.86  96  332 151  109  3
  56  1.01  86  323 158   96  3
  57  0.88  89  323  73   52  3
  58  0.75  83  351  81   42  3
  59  0.99  98  478 151  122  2
  60  1.12 100  398 122  176  3
  61  1.09 110  426 117  118  3
  62  1.02  88  439 208  244  2
  63  1.19 100  429 201  194  2
  64  1.06  80  333 131  136  3
  65  1.20  89  472 162  257  2
  66  1.05  91  436 148  167  2
  67  1.18  96  418 130  153  3
  68  1.01  95  391 137  248  3
  69  0.91  82  390 375  273  3
  70  0.81  84  416 146   80  3
  71  1.10  90  413 344  270  2
  72  1.03 100  385 192  180  3
  73  0.97  86  393 115   85  3
  74  0.96  93  376 195  106  3
  75  1.10 107  403 267  254  3
  76  1.07 112  414 281  119  3
  77  1.08  94  426 213  177  2
  78  0.95  93  364 156  159  3
  79  0.74  93  391 221  103  3
  80  0.84  90  356 199   59  3
  81  0.89  99  398  76  108  3
  82  1.11  93  393 490  259  3
  83  1.19  85  425 143  204  2
  84  1.18  89  318  73  220  3
  85  1.06  96  465 237  111  2
  86  0.95 111  558 748  122  2
  87  1.06 107  503 320  253  2
  88  0.98 114  540 188  211  2
  89  1.16 101  469 607  271  2
  90  1.18 108  486 297  220  2
  91  1.20 112  568 232  276  2
  92  1.08 105  527 480  233  2
  93  0.91 103  537 622  264  2
  94  1.03  99  466 287  231  2
  95  1.09 102  599 266  268  2
  96  1.05 110  477 124   60  2
  97  1.20 102  472 297  272  2
  98  1.05  96  456 326  235  2
  99  1.10  95  517 564  206  2
 100  1.12 112  503 408  300  2
 101  0.96 110  522 325  286  2
 102  1.13  92  476 433  226  2
 103  1.07 104  472 180  239  2
 104  1.10  75  455 392  242  2
 105  0.94  92  442 109  157  2
 106  1.12  92  541 313  267  2
 107  0.88  92  580 132  155  2
 108  0.93  93  472 285  194  2
 109  1.16 112  562 139  198  2
 110  0.94  88  423 212  156  2
 111  0.91 114  643 155  100  2
 112  0.83 103  533 120  135  2
 113  0.92 300 1468  28  455  1
 114  0.86 303 1487  23  327  1
 115  0.85 125  714 232  279  1
 116  0.83 280 1470  54  382  1
 117  0.85 216 1113  81  378  1
 118  1.06 190  972  87  374  1
 119  1.06 151  854  76  260  1
 120  0.92 303 1364  42  346  1
 121  1.20 173  832 102  319  1
 122  1.04 203  967 138  351  1
 123  1.16 195  920 160  357  1
 124  1.08 140  613 131  248  1
 125  0.95 151  857 145  324  1
 126  0.86 275 1373  45  300  1
 127  0.90 260 1133 118  300  1
 128  0.97 149  849 159  310  1
 129  1.16 233 1183  73  458  1
 130  1.12 146  847 103  339  1
 131  1.07 124  538 460  320  1
 132  0.93 213 1001  42  297  1
 133  0.85 330 1520  13  303  1
 134  0.81 123  557 130  152  1
 135  0.98 130  670  44  167  1
 136  1.01 120  636 314  220  1
 137  1.19 138  741 219  209  1
 138  1.04 188  958 100  351  1
 139  1.06 339 1354  10  450  1
 140  1.03 265 1263  83  413  1
 141  1.05 353 1428  41  480  1
 142  0.91 180  923  77  150  1
 143  0.90 213 1025  29  209  1
 144  1.11 328 1246 124  442  1
 145  0.74 346 1568  15  253  1
;



/* The DRAFTUSA Data Set: Draft Lottery Data

   The DRAFTUSA data set contains a rank ordering of the days of the
   year from the draft lottery conducted by the U.S. Selective
   Service in December of 1969.  The priority number assigned to each
   day of the year is the order in which draft-eligible men born on that
   day would have been drafted into the armed forces in 1970.

   The data set DRAFTUSA contains the following variables:

   DAY:      day of the month (1-31)
   MONTH:    month of the year (1-12)
   PRIORITY: draft priority number (1-366)
*/

title 'USA Draft Lottery Data';
proc format;
     value mon   1='Jan'  2='Feb'  3='Mar'  4='Apr'  5='May'  6='Jun'
                 7='Jul'  8='Aug'  9='Sep' 10='Oct' 11='Nov' 12='Dec';
data draftusa;
     input day mon1-mon12;
     drop  i mon1-mon12;
     array mon{12} mon1-mon12;
     do i = 1 to 12;
        month=i;
        priority = mon{i};
        if priority ^=. then output;
        end;

*   Date  Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec ;
cards;
       1  305  086  108  032  330  249  093  111  225  359  019  129
       2  159  144  029  271  298  228  350  045  161  125  034  328
       3  251  297  267  083  040  301  115  261  049  244  348  157
       4  215  210  275  081  276  020  279  145  232  202  266  165
       5  101  214  293  269  364  028  188  054  082  024  310  056
       6  224  347  139  253  155  110  327  114  006  087  076  010
       7  306  091  122  147  035  085  050  168  008  234  051  012
       8  199  181  213  312  321  366  013  048  184  283  097  105
       9  194  338  317  219  197  335  277  106  263  342  080  043
      10  325  216  323  218  065  206  284  021  071  220  282  041
      11  329  150  136  014  037  134  248  324  158  237  046  039
      12  221  068  300  346  133  272  015  142  242  072  066  314
      13  318  152  259  124  295  069  042  307  175  138  126  163
      14  238  004  354  231  178  356  331  198  001  294  127  026
      15  017  089  169  273  130  180  322  102  113  171  131  320
      16  121  212  166  148  055  274  120  044  207  254  107  096
      17  235  189  033  260  112  073  098  154  255  288  143  304
      18  140  292  332  090  278  341  190  141  246  005  146  128
      19  058  025  200  336  075  104  227  311  177  241  203  240
      20  280  302  239  345  183  360  187  344  063  192  185  135
      21  186  363  334  062  250  060  027  291  204  243  156  070
      22  337  290  265  316  326  247  153  339  160  117  009  053
      23  118  057  256  252  319  109  172  116  119  201  182  162
      24  059  236  258  002  031  358  023  036  195  196  230  095
      25  052  179  343  351  361  137  067  286  149  176  132  084
      26  092  365  170  340  357  022  303  245  018  007  309  173
      27  355  205  268  074  296  064  289  352  233  264  047  078
      28  077  299  223  262  308  222  088  167  257  094  281  123
      29  349  285  362  191  226  353  270  061  151  229  099  016
      30  164    .  217  208  103  209  287  333  315  038  174  003
      31  211    .  030    .  313   .   193  011    .  079    .  100
;



/* The DUNCAN Data Set: Duncan Occupational Prestige Data

   The DUNCAN data set gives measures of income, education, and
   occupational prestige for 45 occupational titles for which
   income and education data were available in the 1950 U.S. Census.

   The variables are defined as follows:

   JOB:      abbreviated job title.
   TITLE:    census occupational category.
   INCOME:   proportion of males in a given occupational category reporting
             income of $3,500 or more in the 1950 U.S. Census.
   EDUC:     proportion of males in each occupation with at least a high
             school education in that census.
   PRESTIGE: percent of people rating the general standing of someone
             engaged in each occupation as good or excellent, using a
             five-point scale.  The survey of almost 3,000 people was
             conducted by the National Opinion Research Center.
*/

title 'Duncan Occupational Prestige Data';
data duncan;
  input job $ 1-15 title $ 16-50 income educ prestige;
  case=_n_;
  index=mod(case, 10);
  label income='Income'          /* % males >= $3500   */
        educ='Education'         /* % males h.s. grad. */
        prestige='Prestige';     /* % good or excellent*/
cards;
Accountant     accountant for a large business     62  86  82
Pilot          airline pilot                       72  76  83
Architect      architect                           75  92  90
Author         author of novels                    55  90  76
Chemist        chemist                             64  86  90
Minister       minister                            21  84  87
Professor      college professor                   64  93  93
Dentist        dentist                             80 100  90
Reporter       reporter on a daily newspaper       67  87  52
Civil Eng.     civil engineer                      72  86  88
Undertaker     undertaker                          42  74  57
Lawyer         lawyer                              76  98  89
Physician      physician                           76  97  97
Welfare Wrkr.  welfare worker for city government  41  84  59
PS Teacher     instructor in the public schools    48  91  73
RR Conductor   railroad conductor                  76  34  38
Contractor     building contractor                 53  45  76
Factory Owner  owner of a factory employing 100    60  56  81
Store Manager  manager of a small store in a city  42  44  45
Banker         banker                              78  82  92
Bookkeeper     bookkeeper                          29  72  39
Mail carrier   mail carrier                        48  55  34
Insur. Agent   insurance agent                     55  71  41
Store clerk    clerk in a store                    29  50  16
Carpenter      carpenter                           21  23  33
Electrician    electrician                         47  39  53
RR Engineer    railroad engineer                   81  28  67
Machinist      trained machinist                   36  32  57
Auto repair    automobile repairman                22  22  26
Plumber        plumber                             44  25  29
Gas stn attn   filling-station attendant           15  29  10
Coal miner     coal miner                           7   7  15
Motorman       streetcar motorman                  42  26  19
Taxi driver    taxi-driver                          9  19  10
Truck driver   truck-driver                        21  15  13
Machine opr.   machine-operator in a factory       21  20  24
Barber         barber                              16  26  20
Bartender      bartender                           16  28   7
Shoe-shiner    shoe-shiner                          9  17   3
Cook           restaurant cook                     14  22  16
Soda clerk     soda fountain clerk                 12  30   6
Watchman       night watchman                      17  25  11
Janitor        janitor                              7  20   8
Policeman      policeman                           34  47  41
Waiter         restaurant waiter                    8  32  10
;




/* The FUEL Data Set: Fuel Consumption Data

   The FUEL data set gives the following variables for each of the
   48 contiguous U.S. states:

 AREA:    state area (square miles)
 POP:     1971 state population (thousands)
 TAX:     1972 motor fuel tax (cents per gallon)
 NLIC:    1971 number licensed drivers (thousands)
 DRIVERS: 1971 proportion of licensed drivers
 INC:     1972 per capita personal income
 ROAD:    1971 length of federal highways (miles)
 FUEL:    1972 per capita fuel consumption
*/

title 'Fuel Consumption across the US';
data fuel;
   input state $ area pop tax nlic inc road drivers fuel;
   label area   = 'Area (sq. mi.)'
         pop    = 'Population (1000s)'
         tax    = 'Motor fuel tax (cents/gal.)'
         nlic   = 'Number licensed drivers (1000s)'
         drivers= 'Proportion licensed drivers'
         inc    = 'Per Capita Personal income ($)'
         road   = 'Length Federal Highways (mi.)'
         fuel   = 'Fuel consumption (/person)';
*STATE    AREA     POP     TAX    NLIC   INC     ROAD  DRIVERS  FUEL ;
cards;
 AL      50767    3510    7.00    1801   3333    6594   0.513   554
 AR      52078    1978    7.50    1081   3357    4121   0.547   628
 AZ     113508    1945    7.00    1173   4300    3635   0.603   632
 CA     156299   20468    7.00   12130   5002    9794   0.593   524
 CO     103595    2357    7.00    1475   4449    4639   0.626   587
 CT       4872    3082   10.00    1760   5342    1333   0.571   457
 DE       1932     565    8.00     340   4983     602   0.602   540
 FL      54153    7259    8.00    4084   4188    5975   0.563   574
 GA      58056    4720    7.50    2731   3846    9061   0.579   631
 IA      55965    2883    7.00    1689   4318   10340   0.586   635
 ID      82412     756    8.50     501   3635    3274   0.663   648
 IL      55645   11251    7.50    5903   5126   14186   0.525   471
 IN      35932    5291    8.00    2804   4391    5939   0.530   580
 KS      81778    2258    7.00    1496   4593    7834   0.663   649
 KY      39669    3299    9.00    1626   3601    4650   0.493   534
 LA      44521    3720    8.00    1813   3528    3495   0.487   487
 MA       7824    5787    7.50    3060   4870    2351   0.529   414
 MD       9837    4056    9.00    2073   4897    2449   0.511   464
 ME      30995    1029    9.00     540   3571    1976   0.525   541
 MI      56954    9082    7.00    5213   4817    6930   0.574   525
 MN      79548    3896    7.00    2368   4332    8159   0.608   566
 MO      68945    4753    7.00    2719   4206    8508   0.572   603
 MS      47233    2263    8.00    1309   3063    6524   0.578   577
 MT     145388     719    7.00     421   3897    6385   0.586   704
 NC      48843    5214    9.00    2835   3721    4746   0.544   566
 ND      69300     632    7.00     341   3718    4725   0.540   714
 NE      76644    1525    8.50    1033   4341    6010   0.677   640
 NH       8993     771    9.00     441   4092    1250   0.572   524
 NJ       7468    7367    8.00    4074   5126    2138   0.553   467
 NM     121335    1065    7.00     600   3656    3985   0.563   699
 NV     109894     527    6.00     354   5215    2302   0.672   782
 NY      47377   18366    8.00    8278   5319   11868   0.451   344
 OH      41004   10783    7.00    5948   4512    8507   0.552   498
 OK      68655    2634    6.58    1657   3802    7834   0.629   644
 OR      96184    2182    7.00    1360   4296    4083   0.623   610
 PA      44888   11926    8.00    6312   4447    8577   0.529   464
 RI       1055     968    8.00     527   4399     431   0.544   410
 SC      30203    2665    8.00    1460   3448    5399   0.548   577
 SD      75952     579    7.00     419   4716    5915   0.724   865
 TN      41155    4031    7.00    2088   3640    6905   0.518   571
 TX     262017   11649    5.00    6595   4045   17782   0.566   640
 UT      82073    1126    7.00     572   3745    2611   0.508   591
 VA      39704    4764    9.00    2463   4258    4686   0.517   547
 VT       9273     462    9.00     268   3865    1586   0.580   561
 WA      66511    3443    9.00    1966   4476    3942   0.571   510
 WI      54426    4520    7.00    2465   4207    6580   0.545   508
 WV      24119    1781    8.50     982   4574    2619   0.551   460
 WY      96989     345    7.00     232   4345    3905   0.672   968
;



/* The IRIS Data Set: Iris Data

   The IRIS data set gives measurements on 50 flowers from each of three
   species of iris.
 SPEC_NO:  species number (1=Setosa, 2=Versicolor, 3=Virginica)
 SPECIES:  species name
 SEPALLEN: sepal length in millimeters (mm.)
 SEPALWID: sepal width in mm.
 PETALLEN: petal length in mm.
 PETALWID: petal width in mm.
*/

title 'Fisher (1936) Iris Data';
data iris;
   input sepallen sepalwid petallen petalwid spec_no @@;
   select(spec_no);
      when (1)  species='Setosa    ';
      when (2)  species='Versicolor';
      when (3)  species='Virginica ';
      otherwise ;
   end;
   label sepallen='Sepal length in mm.'
         sepalwid='Sepal width  in mm.'
         petallen='Petal length in mm.'
         petalwid='Petal width  in mm.';
   cards;
50 33 14 02 1  64 28 56 22 3  65 28 46 15 2  67 31 56 24 3
63 28 51 15 3  46 34 14 03 1  69 31 51 23 3  62 22 45 15 2
59 32 48 18 2  46 36 10 02 1  61 30 46 14 2  60 27 51 16 2
65 30 52 20 3  56 25 39 11 2  65 30 55 18 3  58 27 51 19 3
68 32 59 23 3  51 33 17 05 1  57 28 45 13 2  62 34 54 23 3
77 38 67 22 3  63 33 47 16 2  67 33 57 25 3  76 30 66 21 3
49 25 45 17 3  55 35 13 02 1  67 30 52 23 3  70 32 47 14 2
64 32 45 15 2  61 28 40 13 2  48 31 16 02 1  59 30 51 18 3
55 24 38 11 2  63 25 50 19 3  64 32 53 23 3  52 34 14 02 1
49 36 14 01 1  54 30 45 15 2  79 38 64 20 3  44 32 13 02 1
67 33 57 21 3  50 35 16 06 1  58 26 40 12 2  44 30 13 02 1
77 28 67 20 3  63 27 49 18 3  47 32 16 02 1  55 26 44 12 2
50 23 33 10 2  72 32 60 18 3  48 30 14 03 1  51 38 16 02 1
61 30 49 18 3  48 34 19 02 1  50 30 16 02 1  50 32 12 02 1
61 26 56 14 3  64 28 56 21 3  43 30 11 01 1  58 40 12 02 1
51 38 19 04 1  67 31 44 14 2  62 28 48 18 3  49 30 14 02 1
51 35 14 02 1  56 30 45 15 2  58 27 41 10 2  50 34 16 04 1
46 32 14 02 1  60 29 45 15 2  57 26 35 10 2  57 44 15 04 1
50 36 14 02 1  77 30 61 23 3  63 34 56 24 3  58 27 51 19 3
57 29 42 13 2  72 30 58 16 3  54 34 15 04 1  52 41 15 01 1
71 30 59 21 3  64 31 55 18 3  60 30 48 18 3  63 29 56 18 3
49 24 33 10 2  56 27 42 13 2  57 30 42 12 2  55 42 14 02 1
49 31 15 02 1  77 26 69 23 3  60 22 50 15 3  54 39 17 04 1
66 29 46 13 2  52 27 39 14 2  60 34 45 16 2  50 34 15 02 1
44 29 14 02 1  50 20 35 10 2  55 24 37 10 2  58 27 39 12 2
47 32 13 02 1  46 31 15 02 1  69 32 57 23 3  62 29 43 13 2
74 28 61 19 3  59 30 42 15 2  51 34 15 02 1  50 35 13 03 1
56 28 49 20 3  60 22 40 10 2  73 29 63 18 3  67 25 58 18 3
49 31 15 01 1  67 31 47 15 2  63 23 44 13 2  54 37 15 02 1
56 30 41 13 2  63 25 49 15 2  61 28 47 12 2  64 29 43 13 2
51 25 30 11 2  57 28 41 13 2  65 30 58 22 3  69 31 54 21 3
54 39 13 04 1  51 35 14 03 1  72 36 61 25 3  65 32 51 20 3
61 29 47 14 2  56 29 36 13 2  69 31 49 15 2  64 27 53 19 3
68 30 55 21 3  55 25 40 13 2  48 34 16 02 1  48 30 14 01 1
45 23 13 03 1  57 25 50 20 3  57 38 17 03 1  51 38 15 03 1
55 23 40 13 2  66 30 44 14 2  68 28 48 14 2  54 34 17 02 1
51 37 15 04 1  52 35 15 02 1  58 28 51 24 3  67 30 50 17 2
63 33 60 25 3  53 37 15 02 1
;



/* The NATIONS Data Set: Infant Mortality Data

   The NATIONS data set gives the following information on 105 nations
   in 1970:

 NATION:   name of the nation
 REGION:   region of the world
 INCOME:   per capita income
 IMR:      infant mortality rate (per 1,000 live births)
 OILEXPRT: oil exporting country (0=no, 1=yes)
 IMR80:    infant mortality rate, 1980
 GNP80:    GNP per capital, 1980
*/

proc format;
  value region 1='Americas'     2='Africa'
               3='Europe'       4='Asia/Oceania';
  value oil    1='Yes'          0='No';
data nations;
  input nation $ 1-21 income imr region oilexprt imr80 gnp80;
  label income=  'Per Capita Income'
        imr=     'Infant Mortality Rate'
        oilexprt='Oil Exporting Country'
        imr80 =  'Infant Mortality Rate, 1980'
        gnp80 =  'Per Capita GNP, 1980' ;
  format region region. oilexprt oil.;
cards;
Afghanistan               75   400.0     4   0   185.0        .
Algeria                  400    86.3     2   1    20.5     1920
Argentina               1191    59.6     1   0    40.8     2390
Australia               3426    26.7     4   0    12.5     9820
Austria                 3350    23.7     3   0    14.8    10230
Bangladesh               100   124.3     4   0   139.0      120
Belgium                 3346    17.0     3   0    11.2    12180
Benin                     81   109.6     2   0   109.6      300
Bolivia                  200    60.4     1   0    77.3      570
Brazil                   425   170.0     1   0    84.0     2020
Britain                 2503    17.5     3   0    12.6     7920
Burma                     73   200.0     4   0   195.0      180
Burundi                   68   150.0     2   0   150.0      200
Cambodia                 123   100.0     4   0      .         .
Cameroon                 100   137.0     2   0   157.0      670
Canada                  4751    16.8     1   0    12.0    10130
Central Afr. Republic    122   190.0     2   0   190.0      300
Chad                      70   160.0     2   0   160.0      120
Chile                    590    78.0     1   0    40.1     2160
Colombia                 426    62.8     1   0    46.6     1180
Congo                    281   180.0     2   0   180.0      730
Costa Rica               725    54.4     1   0    22.3     1730
Denmark                 5029    13.5     3   0     9.1    12950
Dominican Republic       406    48.8     1   0      .         .
Ecuador                  250    78.5     1   1    72.1     1220
Egypt                    210   114.0     2   0      .         .
El Salvador              319    58.2     1   0    50.8      590
Ethiopia                  79    84.2     2   0    84.2      140
Finland                 3312    10.1     3   0      .         .
France                  3403    12.9     3   0     9.6    11730
Ghana                    217    63.7     2   0   156.0      420
Greece                  1760    27.8     3   0    18.7     4520
Guatemala                302    79.1     1   0    69.2     1110
Guinea                    79   216.0     2   0   216.0      290
Haiti                    100      .      1   0   130.0      270
Honduras                 284    39.3     1   0    31.4      560
India                     93    60.6     4   0   122.0      240
Indonesia                110   125.0     4   1   125.0      420
Iran                    1280      .      4   1   108.1        .
Iraq                     560    28.1     4   1    29.9     3020
Ireland                 2009    17.8     3   0    14.9     4880
Israel                  2526    22.1     4   0    16.0     4500
Italy                   2298    25.7     3   0    15.3     6480
Ivory Coast              387   138.0     2   0   138.0     1150
Jamaica                  727    26.2     1   0    16.2     1030
Japan                   3292    11.7     3   0     8.0     9890
Jordan                   334    21.3     4   0    14.9     1620
Kenya                    169    55.0     2   0    54.1      420
Laos                      71      .      4   0   175.0        .
Lebanon                  631    13.6     4   0    13.6        .
Liberia                  197   159.2     2   0   159.2      520
Libya                   3010   300.0     2   1   130.0     8640
Madagascar               120   102.0     2   0   102.0      350
Malawi                   130   148.3     2   0   142.1      230
Malaysia                 295    32.0     4   0    31.8     1670
Mali                      50   120.0     2   0   120.0      190
Mauritania               174   187.0     2   0   187.0      320
Mexico                   684    60.9     1   0    60.2     2050
Morocco                  279   149.0     2   0   149.0      860
Nepal                     90      .      4   0   133.0      140
Netherlands             4103    11.6     3   0     8.5    11470
New Zealand             3723    16.2     4   0    13.8     7090
Nicaragua                507    46.0     1   0    42.9      720
Niger                     70   200.0     2   0   200.0      330
Nigeria                  220    58.0     2   1   157.0     1010
Norway                  4102    11.3     3   0     8.6    12650
Pakistan                 102   124.3     4   0   124.0      350
Panama                   754    34.1     1   0    22.0     1730
Papua New Guinea         477    10.2     4   0   128.0      780
Paraguay                 347    38.6     1   0    38.6     1340
Peru                     335    65.1     1   0    70.3      950
Philippines              230    67.9     4   0    47.6      720
Portugal                 956    44.8     3   0    38.9     2350
Rwanda                    61   132.9     2   0   127.0      200
Saudi Arabia            1530   650.0     4   1   118.0    11260
Sierra Leone             148   170.0     2   0   136.0      270
Singapore               1268    20.4     4   0    13.2     4480
Somalia                   85   158.0     2   0   177.0        .
South Africa            1000    71.5     2   0    50.0     2290
South Korea              344    58.0     4   0    37.0     1520
South Yemen               96    80.0     4   0   170.0      420
Spain                   1256    15.1     3   0    15.1     5350
Sri Lanka                162    45.1     4   0    42.4      270
Sudan                    125   129.4     2   0    93.6      470
Sweden                  5596     9.6     3   0     7.3    13520
Switzerland             2963    12.8     3   0     8.6    16440
Syria                    334    21.7     4   0    13.0     1340
Taiwan                   261    19.1     4   0      .         .
Tanzania                 120   162.5     2   0   165.0      265
Thailand                 210    27.0     4   0    25.5      670
Togo                     160   127.0     2   0   127.0      410
Trinidad & Tobago        732    26.2     1   0    24.4     4370
Tunisia                  434    76.3     2   0   125.0     1310
Turkey                   435   153.0     4   0   153.0     1460
Uganda                   134   160.0     2   0   160.0      280
United States           5523    17.6     1   0    13.0    11360
Upper Volta               82   180.0     2   0   182.0      190
Uruguay                  799    40.4     1   0    48.5     2820
Venezuela               1240    51.7     1   1    33.7     3630
Vietnam                  130   100.0     4   0   115.0        .
West Germany            5040    20.4     3   0    14.7    13590
Yemen                     77    50.0     4   0   160.0      460
Yugoslavia               406    43.3     3   0    32.2     2620
Zaire                    118   104.0     2   0   104.0      220
Zambia                   310   259.0     2   0   259.0      560
;



/* The SALARY Data Set: Salary Survey Data

   The data set SALARY contains data from a salary survey (fictitious)
   of 46 computer professionals in a large corporation designed to
   investigate the roles of experience, education, and management responsibility
   as determinants of salary (Chatterjee and Price 1977).

   The data set SALARY contains the following variables:

 EXPRNC: experience (years)
 EDUC:   education (1=high school, 2=B.S. degree, 3=advanced degree)
 MGT:    management responsibility (0=no, 1=yes)
 GROUP:  code for education- management group (1-6)
 SALARY: salary, expressed in increments of $1,000

Title 'Salary survey data';
* Formats for group codes;
proc format;
     value glfmt   1='HS' 2='BS' 3='AD' 4='HSM' 5='BSM' 6='ADM';
     value edfmt   1='High School' 2='B.S. Degree' 3='Advanced Degree';
     value mgfmt   0='Non-management' 1='Management';
data salary;
   input case exprnc educ mgt salary;
   label exprnc = 'Experience (years)'
         educ   = 'Education'
         mgt    = 'Management responsibility'
         salary = 'Salary (in $1000s)';

   salary = salary / 1000;
   group = 3*(mgt=1)+educ;
   format group glfmt.;
cards;
 1   1  1  1  13876
 2   1  3  0  11608
 3   1  3  1  18701
 4   1  2  0  11283
 5   1  3  0  11767
 6   2  2  1  20872
 7   2  2  0  11772
 8   2  1  0  10535
 9   2  3  0  12195
10   3  2  0  12313
11   3  1  1  14975
12   3  2  1  21371
13   3  3  1  19800
14   4  1  0  11417
15   4  3  1  20263
16   4  3  0  13231
17   4  2  0  12884
18   5  2  0  13245
19   5  3  0  13677
20   5  1  1  15965
21   6  1  0  12336
22   6  3  1  21352
23   6  2  0  13839
24   6  2  1  22884
25   7  1  1  16978
26   8  2  0  14803
27   8  1  1  17404
28   8  3  1  22184
29   8  1  0  13548
30  10  1  0  14467
31  10  2  0  15942
32  10  3  1  23174
33  10  2  1  23780
34  11  2  1  25410
35  11  1  0  14861
36  12  2  0  16882
37  12  3  1  24170
38  13  1  0  15990
39  13  2  1  26330
40  14  2  0  17949
41  15  3  1  25685
42  16  2  1  27837
43  16  2  0  18838
44  16  1  0  17483
45  17  2  0  19207
46  20  1  0  19346
;


/* The SPENDING Data Set: School Spending Data

   The SPENDING data set lists the estimated expenditure on public
   school education in each of the 50 U.S. states plus the District
   of Columbia in 1970, and several related predictor variables
   (per capita income, proportion of young people, and the degree of
   urbanization in each state).

 ST:       state two-letter postal abbreviation.
 STATE:    state two-digit FIPS code.
 REGION:   geographic region.
 GROUP:    geographic subregion.
 SPENDING: public school expenditures per capita (not per student) in 1970.
           Schools include elementary and secondary schools, as well as
           other programs under the jurisdiction of local school boards,
           but not state universities.
 INCOME:   personal income per capita, 1968.
 YOUTH:    proportion of persons below the age of 18 in 1969, per 1,000
           state population.
 URBAN:    proportion of persons classified as urban in the 1970 census,
           per 1,000 state population.
*/

Proc Format;
   Value $REGION
         'NE' = 'North East'   'NC' = 'North Central'
         'SO' = 'South Region' 'WE' = 'West Region';
   Value $GROUP
         'NE' = 'New England'        'MA' = 'Mid Atlantic'
         'ENC'= 'East North Central' 'WNC'= 'West North Central'
         'SA' = 'South Atlantic'     'ESC'= 'East South Central'
         'WSC'= 'West South Central' 'MT' = 'Mountain States'
         'PA' = 'Pacific States';
Data Schools;
   Input ST $  SPENDING INCOME YOUTH URBAN REGION $ GROUP $;
   STATE=STFIPS(ST);
   LABEL ST = 'State'
         SPENDING='School Expenditures 1970'
         INCOME  ='Personal Income 1968'
         YOUTH   ='Young persons 1969'
         URBAN   ='Proportion Urban';
cards;
ME  189  2824  350.7  508  NE  NE
NH  169  3259  345.9  564  NE  NE
VT  230  3072  348.5  322  NE  NE
MA  168  3835  335.3  846  NE  NE
RI  180  3549  327.1  871  NE  NE
CT  193  4256  341.0  774  NE  NE
NY  261  4151  326.2  856  NE  MA
NJ  214  3954  333.5  889  NE  MA
PA  201  3419  326.2  715  NE  MA
OH  172  3509  354.5  753  NC  ENC
IN  194  3412  359.3  649  NC  ENC
IL  189  3981  348.9  830  NC  ENC
MI  233  3675  369.2  738  NC  ENC
WI  209  3363  360.7  659  NC  ENC
MN  262  3341  365.4  664  NC  WNC
IA  234  3265  343.8  572  NC  WNC
MO  177  3257  336.1  701  NC  WNC
ND  177  2730  369.1  443  NC  WNC
SD  187  2876  368.7  446  NC  WNC
NE  148  3239  349.9  615  NC  WNC
KS  196  3303  339.9  661  NC  WNC
DE  248  3795  375.9  722  SO  SA
MD  247  3742  364.1  766  SO  SA
DC  246  4425  352.1 1000  SO  SA
VA  180  3068  353.0  631  SO  SA
WV  149  2470  328.8  390  SO  SA
NC  155  2664  354.1  450  SO  SA
SC  149  2380  376.7  476  SO  SA
GA  156  2781  370.6  603  SO  SA
FL  191  3191  336.0  805  SO  SA
KY  140  2645  349.3  523  SO  ESC
TN  137  2579  342.8  588  SO  ESC
AL  112  2337  362.2  584  SO  ESC
MS  130  2081  385.2  445  SO  ESC
AR  134  2322  351.9  500  SO  WSC
LA  162  2634  389.6  661  SO  WSC
OK  135  2880  329.8  680  SO  WSC
TX  155  3029  369.4  797  SO  WSC
MT  238  2942  368.9  534  WE  MT
ID  170  2668  367.7  541  WE  MT
WY  238  3190  365.6  605  WE  MT
CO  192  3340  358.1  785  WE  MT
NM  227  2651  421.5  698  WE  MT
AZ  207  3027  387.5  796  WE  MT
UT  201  2790  412.4  804  WE  MT
NV  225  3957  385.1  809  WE  MT
WA  215  3688  341.3  726  WE  PA
OR  233  3317  332.7  671  WE  PA
CA  273  3968  348.4  909  WE  PA
AK  372  4146  439.7  484  WE  PA
HI  212  3513  382.9  831  WE  PA
;


/* The TEETH Data Set: Mammals' Teeth Data

   The data set TEETH lists the number of each of eight types of
   teeth found in 32 species of mammals.  The data set contains
   the following variables:

 MAMMAL: name of mammal
 ID:     observation number, as a two-digit character string
 V1:     number of top incisors
 V2:     number of bottom incisors
 V3:     number of top canines
 V4:     number of bottom canines
 V5:     number of top premolars
 V6:     number of bottom premolars
 V7:     number of top molars
 V8:     number of bottom molars
*/

data teeth;
   title "Mammals' Teeth Data";
   input mammal $ 1-16 @21 (v1-v8) (1.);
   length id $2;
   id=put(_n_,z2.);
   format v1-v8 1.;
   label v1='Top incisors'
         v2='Bottom incisors'
         v3='Top canines'
         v4='Bottom canines'
         v5='Top premolars'
         v6='Bottom premolars'
         v7='Top molars'
         v8='Bottom molars';
   cards;
BROWN BAT           23113333
MOLE                32103333
SILVER HAIR BAT     23112333
PIGMY BAT           23112233
HOUSE BAT           23111233
RED BAT             13112233
PIKA                21002233
RABBIT              21003233
BEAVER              11002133
GROUNDHOG           11002133
GRAY SQUIRREL       11001133
HOUSE MOUSE         11000033
PORCUPINE           11001133
WOLF                33114423
BEAR                33114423
RACCOON             33114432
MARTEN              33114412
WEASEL              33113312
WOLVERINE           33114412
BADGER              33113312
RIVER OTTER         33114312
SEA OTTER           32113312
JAGUAR              33113211
COUGAR              33113211
FUR SEAL            32114411
SEA LION            32114411
GREY SEAL           32113322
ELEPHANT SEAL       21114411
REINDEER            04103333
ELK                 04103333
DEER                04003333
MOOSE               04003333
;



/* The WHEAT Data Set: Broadbalk Wheat Data

   The data set WHEAT contains the yields, in bushels of dressed grain
   per acre, from two plots, labeled 9a and 7b, in the Broadbalk wheat
   experiments over the 30 years from 1855 to 1884.  Anscombe (1981)
   reports that the plots had been treated identically with the same type
   and amount of fertilizers, except that plot 9a had received nitrogen
   in the form of nitrate of soda, whereas 7b had received ammonium salts.
   The data set includes the following variables:

 YEAR:     year of experiment, 1855-1884
 YIELDIFF: yield difference, plots 9a and plot 7b
 RAIN:     winter rainfall, November to February (inches)
 PLOT9A:   yield for plot 9a (bushels per acre)
 PLOT7B:   yield for plot 7b (bushels per acre)
*/

*-----------------------------------------------------------------------*
* Yield difference of two plots in Broadbalk wheat field (bushels/acre)
* Source: Fisher, Statistical Methods for Research Workers, table 29
* See also: Anscombe, Statistical computing with APL, p121.
*-----------------------------------------------------------------------*
;
title 'Broadbalk wheat experiment';

data wheat;
     retain year 1855;
     input yieldiff rain plot9a plot7b;
     output;
     year+1;
     label yieldiff ='Yield difference, plots 9a & 7b'
           rain     ='Rainfall, Nov to Feb (inches)';
cards;
-3.38   5.1   29.62  33.00
-4.53   8.1   32.38  36.91
-1.09   7.9   43.75  44.84
-1.38   5.2   37.56  38.94
-4.66   6.2   30.00  34.66
 4.90   9.7   32.62  27.72
-1.19   7.2   33.75  34.94
 7.56   7.9   43.44  35.88
 1.90   7.9   55.56  53.66
 5.28   6.0   51.06  45.78
 3.84   8.9   44.06  40.22
 2.59  11.3   32.50  29.91
 6.97   9.4   29.13  22.16
 8.62   7.8   47.81  39.19
10.75  10.9   39.00  28.25
 4.13   9.5   45.50  41.37
12.13   7.1   34.44  22.31
11.63   8.2   40.69  29.06
13.06  13.3   35.81  22.75
-1.37   6.4   38.19  39.56
 3.87   9.3   30.50  26.63
 7.81  10.5   33.31  25.50
21.00  17.3   40.12  19.12
 5.00  11.0   37.19  32.19
 4.69  12.8   21.94  17.25
-0.25   5.1   34.06  34.31
 9.31  11.2   35.44  26.13
-2.94  11.4   31.81  34.75
 7.07  14.4   43.38  36.31
 2.69   8.7   40.44  37.75
;

