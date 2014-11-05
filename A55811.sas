
 /*-------------------------------------------------------------------*/
 /*           Solutions for Your GUI Applications Development         */
 /*                     Using SAS/AF FRAME Technology                 */
 /*                     by Don Stanley                                */
 /*       Copyright(c) 1998 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 55811                  */
 /*                        ISBN 1-58025-301-6                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Don Stanley                                                 */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to: sasbbu@sas.com                 */
 /* Use this for subject field:                                       */
 /*     Comments for Don Stanley                                      */
 /*                                                                   */
 /*-------------------------------------------------------------------*/



/*	Code for Chapter 1	*/



page 7

SELECT (popmenu(<listid>)) ;
when (1) ...
when (2) ...

otherwise ;
END ;


page10

 length rc 3 text $ 30 ;                                                       
                                                                               
 init:                                                                         
   call notify('request','_cursor_') ;                                         
   call notify('promptr','_hide_') ;                                           
   call notify('request','_set_mode_','NONE') ;                                
   call notify('request','_set_instance_method_','
          _feedback_', 
          'sasuser.book16.methods.scl','fback') ;
 return ;     
 
 assist:                                                                       
 
    if assist eq 'OFF' then do ;                                                
      call notify('promptr','_hide_') ;                                        
      call notify('request','_set_mode_','NONE') ;                             
      call notify('request','_cursor_') ;                                      
  ?    if dsid('sashelp.company') then 
          rc=close(dsid('sashelp.company')) ; 
      return ;
   end ;        
 
                                                         
                                                                               
   dsid = open('sashelp.company','i') ;                                        
   call notify('request','_set_mode_','ALWAYS') ;                              
   call notify('promptr','_unhide_') ;                                         
   call notify('request','_cursor_') ;                                         
 
 
 page 11
 
   call notify('request','_get_text_',text) ;                                  
   if text ne _blank_ then 
      call notify('request','_feedback_',' ',.,.) ;       
   else call notify('promptr','_repopulate_') ;                                
 return ;                                              
 Close the dataset 
if it is open.
 term:                                                                         
    if dsid('sashelp.company') then 
          rc=close(dsid('sashelp.company')) ;                                               
return ;


 promptr:                                                                      
   call notify('promptr','_get_last_sel_',rc,
               rc,text) ;                        
   call notify('request','_set_text_',text) ;                                  
return ;  

 
 rc = close(dsid) ;
  if dsid then rc = close(dsid) ;


 
page 12

 length text $ 200 varname $ 8 rc 3 ;                                          
                                                                            
 _self_ = _self_ ;                                                             
 fback:                                                                        
 method event $ 20 line 8 offset 8 ;                                           
 
   call send(_self_,'_get_text_',text) ;                                       
   call send(_frame_,'_get_widget_','promptr',
             list box) ;                       
                                                                               
 
 
   dsid = dsid('sashelp.company') ;                                            
 
   rc = where(dsid,'level5' !! ' like "' !! 
              text !! '%"') ;                    
 
   call send(list box,'_repopulate_') ;                                         
endmethod ;                                                                   

page 15
 
 entry prompt $ usertext $ input_length empty_allowed 3;                         
                                                                               
 length select1 select2 3 ;                                                    
 
 
 page 16                                                                              
 
 init:                                                                         
  call notify('message','_set_text_',prompt) ;     
                               
  call notify('userfld','_set_maxcol_',
               input_length) ;                         
 
  call notify('userfld','_set_text_',' ') ;                                    
  
 
  call notify('userfld','_cursor_') ;                                          
 
 
  call notify('userfld','_set_tabbable_','on') ;                               
 return ;
 
 
 term:                                                                         
                                                                               
   if _status_ eq 'C' then do ;                                                
     usertext = _blank_ ;                                                      
     return ;                                                                  
   end ;                                                                       
                                                                               
   call notify('userfld','_get_text_',usertext) ;                              
   if not empty_allowed & usertext = _blank_ then do ;                         
     _status_ = 'R' ;                                                          
     _msg_ = 'ERROR: Data Entry Required Before END' ;                         
     return ;                                                                  
   end ;                                                                       
 return ;
 
 userfld:                                                                      
  call notify('end','_is_modified_',select1) ;                                 
  call notify('cancel','_is_modified_',select2) ;                              
  if not select1 and not select2 then call execcmd('end') 
;                    
 return ;


if not empty_allowed then 
    call notify(‘userfld’,’_set_required_’,’Y’) ;



page 17

if _status_ eq 'C' then usertext = _blank_ ;                                                      
length paper $ 25 ;                                                           
                                                                              
init:                                                                         
  call display('runok.frame','Enter paper type',paper,
                8,0) ;                  
  sysrc = sysrc(1);                                                           
  put paper= sysrc=;                                                          
return ;

page 19

tabout:   
  method:              

  /*
   set object border color to background and then 
   execute the SAS/AF _tab_out_ code. Use background    
   for the color so that the border cannot be seen.
  */

  call send(_self_,'_set_border_color_','background') ;   
  call super(_self_,’_tab_out_’) ;                       
endmethod;                                                                       
                                                                              
tabin:   
  method:                                                                     

    /*
     change the border color and then execute the 
     SAS/AF _tab_in_ default
    */
                                                                     
  call send(_self_,'_set_border_color_','pink') ;                             
  call super(_self_,’_tab_in_’) ;
endmethod ;                                                                      
                                                                              

page 20 

 init:                                                                         
 call notify('image1','_set_tabbable_','on') ;                               
   call notify('image2','_set_tabbable_','on') ;                               
   call notify('image1','_set_instance_method_',
               '_tab_out_',                   
               'sasuser.tabout.override.scl',
               'tabout') ;   
                    
 page 21
                                                                              
   call notify('image2','_set_instance_method_',
               '_tab_out_',                   
               'sasuser.tabout.override.scl',
               'tabout') ;                       
                                                                               
   call notify('image1','_set_instance_method_',
               '_tab_in_',                    
               'sasuser.tabout.override.scl',
               'tabin') ;                        
                                                                               
   call notify('image2','_set_instance_method_',
               '_tab_in_',                    
               'sasuser.tabout.override.scl',
               'tabin') ;                        
                                                                               
   call notify('image1','_cursor_') ;                                          
                                                                               
 return

 
tabin:                                                                        
   call send(_self_,'_set_border_color_','pink') ;                             
return ;
 
page 22
 
call execcmd('winsert off') ;
 
page 24

length mytext $ 30 ;                                                          
 
init:                                                                         
                                                                              
  reg  = makelist();                                                          
call notify('clickme','_get_region_',reg,'c');                             
attr = makelist();                                                          
  rc   = setniteml(attr, reg, '_region_');                                    
  rc   = setnitemc(attr, 'tbox', 'name');                                     
                                                                              
                                                                              
return ;                                                                      
               
page 25

term:                                                                         
 if textbox then call send(textbox,'_term_') ;                                
 rc = dellist(reg) ;                                                          
 rc = dellist(attr);                                                          
return ;

clickme:                                                                      
 call notify('clickme','_swap_out_') ;                                        
 if textbox le 0 then                                                         
   textbox = instance(
            loadclass('sashelp.fsp.efield.class'),
            attr);           
 call send(textbox,'_swap_in_') ;                                             
return ;                                                                      

tbox:                                                                         
 call send(textbox,'_get_text_',mytext) ;                                     
 put mytext= ;                                                                
 call send(textbox,'_swap_out_') ;                                            
 call notify('clickme','_swap_in_') ;                                         
return ;


page 27

 bpost:                                                                        
   method ;                                                                    
call super(_self_,'_bpostinit_') ;                                          
                                                                               
 
 
 page 28
 
   call send(_self_,'_get_widgets_',widget_list) ;                             
 
   if listlen(widget_list) gt 0 then return ;                                       
 
                                                                               
   endcheck = makelist() ;                                                     
   rc=insertc(endcheck,'Insert An END Button',-1) ;                          
   rc=insertc(endcheck,'Do Not Insert END Button',-1);                      
                                                                               
   helpcheck = makelist() ;                                                    
   rc=insertc(helpcheck,'Insert A HELP Button',-1) ;                         
   rc=insertc(helpcheck,
              'Do Not Insert HELP Button',-1) ;                    
                                                                               
   call send(_self_,'_WINFO_','STARTROW',sr) ;                                 
   call send(_self_,'_WINFO_','STARTCOL',sc) ;                                 
   call send(_self_,'_WINFO_','NUMROWS',nr) ;                                  
   call send(_self_,'_WINFO_','NUMCOLS',nc) ;                                  
 
   centre = (nc-sc)/2 ;                                                        
   lry = nr - 1 ;                                                              
   lrx = ceil(centre) - 2 ;                                                    
   ulx = lrx - 10 ;                                                            
   uly = lry - 4  ;                                                            
                                                                               
   attr = makelist() ;                                                         
   reg  = makelist() ;                                                         
   rc = setniteml(attr,reg,'_region_') ;                                       
   rc = setnitemc(attr,'C','_justify_') ;                                      
   rc = setnitemn(reg,ulx,'ulx') ;                                             
   rc = setnitemn(reg,uly,'uly') ;                                             
   rc = setnitemn(reg,lrx,'lrx') ;                                             
   rc = setnitemn(reg,lry,'lry') ;                                             
                                                                               
   select(popmenu(endcheck)) ;                                                 
     when (1) do ;                                                             
        rc = setnitemc(attr,'END','name') ;                                    
        end = loadclass('sashelp.fsp.pbutton') ;                               
        call send(end,'_new_',buttend,attr) ;                                  
        call send(buttend,'_set_label_','End') ;                               
        call send(buttend,'_set_cmd_','end') ;                                 
     end ;                                                                     
     otherwise ;                                                               
   end ;             
 
page 29

   select(popmenu(helpcheck)) ;                                                
     when (1) do ;                                                             
        rc = setnitemc(attr,'HELP','name') ;                                   
        rc = setnitemn(reg,lrx+4,'ulx') ;                                      
        rc = setnitemn(reg,lrx+14,'lrx') ;                                     
        help = loadclass('sashelp.fsp.pbutton') ;                              
        call send(help,'_new_',butthlp,attr) ;                                 
        call send(butthlp,'_set_label_','Help') ;                              
        call send(butthlp,'_set_cmd_','Helpmode on') ;                         
     end ;                                                                     
     otherwise ;                                                               
   end ;        
   rc = dellist(endcheck) ;
   rc = dellist(helpcheck) ;          
   rc = dellist(attr) ;
   rc = dellist(reg)  ;                                                    
                                                                               
 endmethod ;


page 34

 
 entry optional= listid 8 _uattr_ $ class 8 ;                                                    
            
  length text $ 8 tip $ 70 rc 3 ;                                              
                                                                               
 init:                                                                         
   frameid = getnitemn(listid,'_frame_') ;                                     
   widget_list = makelist() ;                                                  
   call send(frameid,'_get_widgets_',widget_list) ;                            
       
 
 
                                                                         
   tipslist = makelist() ;                                                     
   widget = makelist() ;                                                       
   
do i=1 to listlen(widget_list) ;                                            
     rc = setnitemc(widget,                                                    
                    nameitem(widget_list),                                     
                    popl(widget_list)) ;                                       
     widget_id = nameitem(widget,i) ;                                          
     if nameditem(widget_id,'TOOLTIP') then                                    
        rc = setnitemc(tipslist,
             getnitemc(widget_id,'TOOLTIP'),widget_id);    
     else rc = setnitemc(tipslist,' ',widget_id) ;                             
   end ;                                                                       
                                                                               
 return ;                                                                      
 
 widgets:                                                                      
   
 
 page 35

   call notify('widgets','_get_last_sel_',rn,issel,
        text) ;                     
   if issel eq 0 then return ;                                                 
                     
                                                           
   call notify('descr','_set_text_',                                           
               getnitemc(nameitem(widget,rn),'DESC'));                         
 
   call notify('tooltip','_cursor_') ;                                         
                           
                                                     
   widget_id = nameitem(widget,rn) ;                                           
                                                                               
   call notify('tooltip','_set_text_',
                getnitemc(tipslist,widget_id)) ;         
 return ;

 term:                                                                         
   if _status_ = 'C' then return ;                                             
     
                                                                           
   do i=1 to listlen(tipslist) ;                                               
      widget_id = nameitem(tipslist,i) ;                                       
      if getitemc(tipslist,i) ne ' ' then do ;                                 
         tip = getitemc(tipslist,i) ;                                          
         rc = setnitemc(widget_id,tip,'TOOLTIP') ;                             
      end ;                                                                    
      else                                                                     
         if nameditem(widget_id,'TOOLTIP') then                                
            rc = delnitem(widget_id,'TOOLTIP') ;                               
   end ;                                                                       
                                                                               
   rc = dellist(tipslist) ;                                                    
   rc = dellist(widget) ;  
   rc = dellist(widget_list) ;                                                    
 return ;
 
 tooltip:                                                                      
   call notify('tooltip','_get_text_',tip) ;                                   
   rc = setnitemc(tipslist,tip,widget_id) ;                                    
 return ;

page 37

 _self_ = _self_ ; _frame_ = _frame_ ;                                         
                                                                               
 postinit:
 method ;                                                                      
                                                                               
   call super(_self_,'_postinit_') ;                                           
                                                                               
                                                                               
   widget_list = makelist() ;
   call send(_self_,'_get_widgets_',widget_list) ;                             
                                                                               
                                                                               
   trackon = 0 ;                                                             
 
 
   do i=1 to listlen(widget_list) ;                                          
     widget_id = popl(widget_list) ;                                         
     if nameditem(widget_id,'TOOLTIP') then do ;                             
        call send(widget_id,'_set_instance_method_',
                  '_cursor_tracker_',      
                  'dgs.toolbox.tooltips.scl',
                  'tracker') ;                       
        call send(widget_id,'_cursor_tracking_on_') ;                        
        trackon = 1 ;                                                        
     end ;                                                                   
   end ;                  
    
   rc = dellist(widget_list) ;
                      
 
                            
   if trackon eq 1 then 
       call send(_frame_,'_cursor_tracking_on_') ;          
 endmethod ;
 
 tracker:                                                                      
 method x y 8 ;                                                                
   call send(_frame_,'_set_msg_',
             getnitemc(_self_,'TOOLTIP')) ;                
 endmethod ;
 FRAME cursor 
tracking. Blank out 
the message area.
 ftrack:                                                                       
 method x y 8 ;                                                                
   call send(_frame_,'_set_msg_',' ') ;                                        
 endmethod ;

page 38

init:                                                                         
return ;                                                                      
page 47

if not modified(‘obj1’) then link obj1 ;
if not modified(‘obj2’) then link obj2 ;


if error(objname) then link <label> ;

page 48

label1:
  if <error condition> then do ;
    _msg_ = ‘....’ ;
    erroron label1 ;
    return ;
  end ;
 ... non error processing ...
return ;

label2:
  if <error condition> then do ;
    if _msg_ eq ‘ ‘ then 
       _msg_ = ‘....’ ;
    erroron label2 ;
    return ;
  end ;
  .. non error processing ...
return ;

page 50

call notify('.','_set_instance_method_','_postinit_',                       
            'sasuser.book24.methods.scl','postinit') ;


 postinit:                                                                     
   method ;            
   widget_list = makelist() ;                                                        
   call send(_self_,'_get_widgets_',widget_list) ;                            
do i=1 to listlen(widget_list) ;                                            
    
 
 
 page 51
 
    curr_widget = getiteml(widget_list,i) ;                                  
 
    if nameditem(curr_widget,'HELP') eq 0 then                               
 
 
     call send(curr_widget,'_set_instance_method_', 
       '_help_','sasuser.book24.methods.scl',
       'help') ;                 
 
    else 
    if getnitemc(curr_widget,'HELP') eq ‘ ‘ then                    
     call send(curr_widget,'_set_instance_method_',
             '_help_',               
             'sasuser.book24.methods.scl','help') ;               
  end ;                                                                       
                                                                               
  if nameditem(_self_,'HELP') eq 0 then
   call send(_self_,'_set_instance_method_',
     '_help_','sasuser.book24.methods.scl','help');                            
  else if getnitemc(_self_,'HELP') eq _blank_ then                           
   call send(_self_,'_set_instance_method_',
             '_help_',                      
             'sasuser.book24.methods.scl','help') ;
 
   rc = dellist(widget_list) ;
 
 
   call super(_self_,'_postinit_') ;                                          
 endmethod ;



help:
  method ;
  endmethod ;



help:
  method ;
    call send(_frame_,’_set_msg_,
              ’No HELP Available For This Object’) ;
  endmethod ;


/*	Chapter 2	*/



page 56

call notify('request','_set_instance_method_',
            '_feedback_',                 
            ‘dgs.toolbox.methods.scl','fback') ;

page 66

 Entry optional= _widget_ 8 _uattr_ $ class 8 ;                                
                                                                               
 length rc 3 ;                                                                 
                                                                               
 init:                                                                         
   name = getnitemc(_widget_,'name');                                          
   prompt = getnitemc(_widget_,’prompt’) ;                                   
   text = getnitemc(_widget_,'text') ;                                         
 return ;
 
 term:                                                                         
                                                                               
   if _status_ eq 'C' then return ;                                            
                                                                               
 
   rc = setnitemc(_widget_,name,'name') ;                                   
   rc = setnitemc(_widget_,prompt,'prompt') ;                             
   rc = setnitemc(_widget_,text,'text') ;                                   
 return ;

page 69

 entry dataset $ ;                                         
                                                                               
 init:                                                                         
  dataset = _blank_ ;                                                          
  control error ; 
                                                                               
  call notify(‘prompt’,'_set_text_',                                           
               getnitemc(_self_,’prompt’)) ;                               
 
 
 
 
 cursor dataset ;                                                                              
 return ;
 
 dataset:
 
 if error(dataset) then do ;                                               
       call notify('.','_set_msg_',
             'Invalid SAS Dataset Name') ;              
       return ;                                                               
    end ;                                                                     
    else do ;                                                                 
      call notify('dataset','_erroroff_') ;                                   
      call notify('.','_set_msg_',' ') ;                                      
     end ;
 return ;

 term:                                                                         
   if _status_ eq 'C' then dataset = _blank_ ;                                 
 return ;

page 70

 length dataset1 dataset2 $ 17 ;                                               
 
 getset1:                                                                      
   call notify('getset1',’get_dsname’,dataset1) ;
   put dataset2= ;                 
 return ;                                                                      
                                                                               
                                                                               
 getset2:                                                                      
   call notify('getset2',’get_dsname’,dataset2) ;
   put dataset2= ;                 
 return ;                                                                      

page 71

length dataset $ 17 ;                                           
select:                                                         
  method ;                                                      
    call send(_self_,’get_dsname’,dataset) ;                      
    call send(_self_,'_set_text_',dataset) ;                   
    call super(_self_,'_select_') ;                       
  endmethod ;

main:
  put getset1= ;
return ;

page 74

length popper attr tmp 3 ;                                                    
_self_ = _self_ ;                                                            

 
poplist:                                                                      
  method sel_item 3 text $ 60 ;                                                     
                                                                              
call send(_self_,'get_list_id',popper) ;                                  
                                                                              
 
    sel_item = popmenu(popper) ;                                                    
    if sel_item then text = getitemc(popper,sel_item);                                   
    else text = _blank_ ;                                                     
  endmethod;                                                                  
 
listids:                                                                      
  method popper 8 ;                                                           
                                                                              
   popper = getniteml(_self_,'poplist') ;                                     
                                                                              
 endmethod ;

page 77
  
 entry optional= _widget_ 8 _uattr_ $ class 8 ;                                
                                                                               
 
 
 length text $ 60 rc 8 poplist 8 ;                                             
                                                                               
 init:                                                                         
   poplist = getniteml(_widget_,'poplist') ;                                   
 
 
   tmplist = copylist(poplist) ;                                               
 
   if listlen(tmplist) lt 15 then  

page 78
                                            
   do item=listlen(tmplist)+1 to 15 ;                                          
     rc = insertc(tmplist,' ',item,put(item,z2.)) ;                            
   end ;          
 
                                                                               
   call notify('select','_gray_') ;                                            
   call notify('delete','_gray_') ;                                            
   call notify('moveup','_gray_') ;                                            
   call notify('movedown','_gray_') ;                                          
                                                                               
 return ;                                                                      
 

  term:                                                                         
   if _status_ = 'C' then do ;                                                 
      rc = dellist(tmplist) ;                                                  
      return ;                                                                 
   end ;                                                                       
   
                                                                             
   do item = 15 to 1 by -1 ;                                                   
     if getitemc(tmplist,item) = ' ' then                                      
        rc = delitem(tmplist,item) ;                                           
     else leave ;                                                              
   end ;                                                                       
         
 
                                                                       
   if listlen(poplist) gt listlen(tmplist) then                                
     do item = listlen(tmplist)+1 to listlen(poplist);                        
        rc = setlattr(poplist,'nowrite',item) ;                                
   end ;                                                                       
 
   rc = copylist(tmplist,'no',poplist) ;                                       
    
 
                                                                            
   rc = dellist(tmplist) ;                                                     
 return ;                                                                       
 
 get1:     
 
 
 
 
page 79
                                                                     
   call notify('popper','_get_widgets_',widget_list) ;                         
   listitem_object_id = getiteml(widget_list,1) ;                              
 
 
   call send(listitem_object_id,'_set_text_',
             getitemc(tmplist,_currow_)) ;     
 
   if hasattr(tmplist,'INACTIVE',_currow_) then                                
      call send(listitem_object_id,'_set_color_',
               'red') ;                      
   else                                                                        
      call send(listitem_object_id,'_set_color_',
               'black') ;                    
 return ;
 
 clearlst:                                                                     
   do item=1 to 15 ;                                                           
      rc = setitemc(tmplist,' ',item) ;                                        
      rc = setlattr(tmplist,'ACTIVE',item) ;                                   
   end ;                                                                       
 
   call notify('select','_gray_') ;                                            
   call notify('delete','_gray_') ;                                            
   call notify('moveup','_gray_') ;                                            
   call notify('movedown','_gray_') ;                                          
   call notify('border','_set_border_title_','') ;                             
 
 
 
                                                                               
   call notify('popper','_unselect_all_') ;                                    
 return ;

  movedown:    
 
 
 
   call notify('popper','_get_last_sel_',row,issel) ;                          
   if issel = 0 then return ;                                                  
   
 
 page 80
                                                                             
   text = getitemc(tmplist,row) ;                                              
   attr = hasattr(tmplist,'INACTIVE',row) ;                                    
                                                                               
   text1= getitemc(tmplist,row+1) ;                                            
   attr1 = hasattr(tmplist,'INACTIVE',row+1) ;                                 
                                                                               
   rc = setitemc(tmplist,text1,row) ;                                          
   rc = setitemc(tmplist,text,row+1) ;                                         
                                                                               
   if  attr then                                                               
       rc = setlattr(tmplist,'INACTIVE',row+1) ;                               
   else rc = setlattr(tmplist,'ACTIVE',row+1) ;                                
                                                                               
   if  attr1 then                                                              
       rc = setlattr(tmplist,'INACTIVE',row) ;                                 
   else rc = setlattr(tmplist,'ACTIVE',row) ;                                  
                                                                               
   if row+1 eq 15 then 
      call notify('movedown','_gray_') ;                      
 
 
   call notify('moveup','_ungray_') ;                                          
                          
 
                                                      
   call notify('popper','_select_row_',row,'OFF') ;                            
   call notify('popper','_select_row_',row+1,'ON') ;                           
   call notify('border','_set_border_title_',                                  
    'Selected Row ' || put(row+1,2.)) ;                                        
 return ;
 
 moveup:                                                                       
   call notify('popper','_get_last_sel_',row,issel) ;                          
   if issel = 0 then return ;                                                  
                                                                               
   text = getitemc(tmplist,row) ;                                              
   attr = hasattr(tmplist,'INACTIVE',row) ;                                    
                                                                               
   text1= getitemc(tmplist,row-1) ;                                            
   attr1 = hasattr(tmplist,'INACTIVE',row-1) ;                                 
                                                                               
   rc = setitemc(tmplist,text1,row) ;                                          
   rc = setitemc(tmplist,text,row-1) ;                                         
                                                                               
   if attr then                                                                
       rc = setlattr(tmplist,'INACTIVE',row-1) ;                               
   else rc = setlattr(tmplist,'ACTIVE',row-1) ; 

                               
 page 81
                                                                              
   if  attr1 then                                                              
       rc = setlattr(tmplist,'INACTIVE',row) ;                                 
   else rc = setlattr(tmplist,'ACTIVE',row) ;                                  
                                                                               
   if row-1 eq 1 then call notify('moveup','_gray_') ;                         
   call notify('movedown','_ungray_') ;                                        
                                                                               
   call notify('popper','_select_row_',row,'OFF') ;                            
   call notify('popper','_select_row_',row-1,'ON') ;                           
                                                                               
   call notify('border','_set_border_title_',                                  
    'Selected Row ' || put(row-1,2.)) ;                                        
 return ;
 
 delete:                                                                       
   call notify('popper','_get_last_sel_',row,issel) ;                          
   if issel = 0 then return ;                                                  
                                                                               
   rc = delitem(tmplist,row) ;                                                 
   rc = insertc(tmplist,' ',15) ;                                              
                                                                               
   call notify('popper','_unselect_all_') ;                                    
 
 
   call notify('border','_set_border_title_','') ;                             
 
                                                                               
   call notify('select','_gray_') ;                                            
   call notify('delete','_gray_') ;                                            
   call notify('moveup','_gray_') ;                                            
   call notify('movedown','_gray_') ;                                          
 
                                                                               
   call notify('select','_activate_',0) ;                                      
   call notify('delete','_activate_',0) ;                                      
 return ;

  select:                                                                       
   call notify('popper','_get_last_sel_',row,issel) ;                          
   if issel = 0 then return ;                                                  
                                                                               
   if select = 'NOSELECT' then                                                   
      rc = setlattr(tmplist,'INACTIVE',row) ;                                  
   else rc = setlattr(tmplist,'ACTIVE',row) ;                                  
                                                                               
   call notify('popper','_need_refresh_') ;                                    
 return ;


page 82

 put1:                                                                         
 
 
   call notify('popper','_get_widgets_',widget_list) ;                         
   listitem_object_id = getiteml(widget_list,1) ;                              
 
   call send(listitem_object_id,'_get_text_',text) ;                           
   rc = setitemc(tmplist,text,_currow_) ;                                      
 
   call notify('popper','_ISSEL_',_currow_,issel) ;
 
   if issel = 0 then do ;                                                      
      call notify('select','_gray_') ;                                         
      call notify('delete','_gray_') ;                                         
      call notify('moveup','_gray_') ;                                         
      call notify('movedown','_gray_') ; 
      call notify('border','_set_border_title_','') ;                          
      return ;                                                                 
   end ;                                                                       
                                                                               
   call notify('select','_ungray_') ;                                          
   call notify('delete','_ungray_') ;                                          
 
 
   if _currow_ ne 1  then 
      call notify('moveup','_ungray_') ;                   
   else call notify('moveup','_gray_') ;                                       
 
   if _currow_ ne 15 then 
      call notify('movedown','_ungray_') ;                 
   else call notify('movedown','_gray_') ;    
                                 
 
 page 83
                                                                              
   call notify('border','_set_border_title_',                                  
    'Selected Row ' || put(_currow_,2.)) ;                                     
 
 
 
 
                                                                               
   if hasattr(tmplist,'INACTIVE',_currow_) then 
      call notify('select','_activate_',1) ;                                   
   else                                                                 
      call notify('select','_activate_',0) ;                                   
 return ;   

                                                                    
 
page 84

  length text $ 30 ;                                                            
                                                                               
 obj1:                                                                         
   call notify('obj1','pop_up_list',rc,text) ;                                 
   put rc= text= ;                                                             
 return ;                                                                      
                                                                               
 obj2:                                                                         
   call notify('obj2','pop_up_list',rc,text) ;                                 
   put rc= text= ;                                                             
 return ;

 
page 86

seterror:                                                                     
  method error_id 8 ;                                                         
                                                                              
  rc = setnitemn(_self_,error_id,
          'error_handler_object_id') ;                 
                                                                              
endmethod  ;                                                                  
 
geterror:                                                                     
  method error_id 8 ;                                                         
                                                                              
  error_id = getnitemn(_self_,
                 'error_handler_object_id') ;                    
                                                                              
endmethod  ;
 length object_name $ 8;                                           
   
 
 rc = rc ;                                                                            
 _self_ = _self_ ;                                                             
 _frame_ = _frame_ ;                                                           
                                                                               
               
 
 
 
                                                                 
 postinit:                                                                     
 method ;                                                                      
  
   call super(_self_,'_postinit_') ;                                           
                   
 
 page 87
                                                             
   attr = makelist() ;                                                         
   reg  = makelist() ;                                                         
   rc = setniteml(attr,reg,'_region_') ;                                       
   rc = setnitemn(reg,2,'ulx') ;                                               
   rc = setnitemn(reg,0,'uly') ;                                               
   rc = setnitemn(reg,10,'lrx') ;                                              
   rc = setnitemn(reg,3,'lry') ;                                               
   rc = setnitemc(reg,'mm','units') ;                                          
                                                                               
 
   errmess = loadclass('sashelp.fsp.glabel') ;                                 
   call send(errmess,'_new_',errors,attr) ;                                    
                                                                               
  
   call send(errors,'_set_autoflow_','Y') ;                                    
   call send(errors,'_set_color_','red') ;                                     
   call send(errors,'_protect_') ;                                             
   call send(errors,'_set_border_style_','button',3) ;                         
   call send(errors,'_set_background_color_','yellow');                       
   call send(errors,'_hide_') ;                                                
   call send(_self_,'set_error_handler',errors) ;                              
                          
 
                                                      
   widget = loadclass('sashelp.fsp.widget') ;                                  
   call send (widget, '_set_method_', 'show_error',                            
                 'sasuser.book01.framecls.scl',                                
                 'showerr');                                                   
                         
   rc = dellist(attr,’Y’) ;
                                                       
 endmethod ;      
 

page 88

tracker:                                                                      
method x y 8;                                                                 
                                                                              
  call send(_self_,'get_error_handler',errors) ;                              
  call send(errors,'_hide_') ;                                                
endmethod ;

 
page 89

 enderror:                                                                     
 method ;                                                                      
                                                                               
  
   call super(_self_,'_erroroff_') ;                                           
                                                                               
   call send(_frame_,'get_error_handler',errors) ;                             
   call send(errors,'_hide_') ;                                                
                                                                               
   call send(_self_,'_cursor_tracking_off_') ;                                 
 endmethod ;          
 
 Showerr:                                                                      
 
  method error_text $ 200 ;                                                     
                                                                               
 
   call send(_self_,'_get_name_',object_name) ;                                
   call send (_frame_, '_get_table_', object_name, 
              table_id);                  
   if table_id then return ;                                                   
 
 
 page 90
 
 
   call send(_self_,'_cursor_tracking_on_') ;                                  
                                                                               
   call send(_frame_,'_cursor_tracking_on_') ;                                 
                                                                               
 
   rc = setnitemc(_self_,error_text,'dons_error_text') 
;                       
 
 
                                                                               
   call send (_self_, '_set_instance_method_',
                 '_erroroff_',                   
                 'sasuser.book01.framecls.scl',                                
                 'enderror', 'before');                                        
                                                                               
   call send (_self_, '_set_instance_method_', 
                 '_cursor_tracker_',             
                 'sasuser.book01.framecls.scl',                                
                 'widtrack', 'before');                                        
                                                                               
 endmethod ; 

 widtrack:                                                                     
   method x y 8 ;                                                              
     
 
 
                                                                           
   call send(_frame_,'get_error_handler',errors) ;                             
   error_text = getnitemc(_self_,'dons_error_text') ;                          
                 
 
                                                               
   call send(_frame_,'_winfo_',"numcols",nc) ;                                 
 
 
   call send(errors,'_set_maxcol_',nc-2) ;                                     
 
 
 
 
   call send(errors,'_set_maxrow_',3) ;                                        
   call send(errors,'_clear_') ;                                               
   call send(errors,'_set_text_',error_text) ;                                 
   call send(errors,'_snug_fit_') ;                                            
   call send(errors,'_unhide_') ;                                              
                                                                               
 endmethod ;          

page 92                                                        
 

length text $ 17  ;                                                           
                                                                              
                                                                              
init:                                                                         
  call notify('tractest','_cursor_') ;                                        
return ;                                                                      
                                                                              
                                                                              
tractest:                                                                     
 call notify('tractest','_erroroff_') ;                                       
                                                                              
 call notify('tractest','_get_text_',text) ;                                  
                                                                              
 if upcase(text) ne 'SASUSER.TEXT' then do ;                                  
    call notify('tractest','_erroron_') ;                                     
    _msg_ = 'ERROR: Invalid Dataset Name : ' !! text ;                        
    call notify('tractest','show_error',                                      
 'You Must Enter A Dataset Name. Click On the Arrow To 
Get A List Of '     
   !! 'Dataset Names that can be used in this context, 
or type in a'     
   !! 'valid dataset name') ;                                            
 end ;                                                                        
return ;                                                                      
                                                                              
                                                                              
test2:                                                                        
 call notify('test2','_erroroff_') ;                                          
                                                                              
 call notify('test2','_get_text_',text) ;                                     
                                                                              
 if upcase(text) ne 'SASUSER.THIS' then do ;                                  
   call notify('test2','_erroron_') ;                                         
   _msg_ = 'ERROR: Invalid Dataset Name : ' !! text ;                         
   call notify('test2','show_error',                                          
'The dataset name is invalid. Please Fix It and Press 
Enter.
        ') ;              
 end ;                                                                        
return ;


page 95

 initial:
   method counter_list_name $ 8 libref $ 8 catname $ 8;
 
   storage = libref || '.' || catname || '.' || 
             counter_list_name || '.slist' ;
 
   rc = setnitemc(_self_,storage,'saved_list_name') ;
 
 
   if cexist(storage) eq 0 then do ;
     rc = setnitemn(_self_,0,'last_used_counter');
     rc = savelist('catalog',
                   getnitemc(_self_,'saved_list_name'),
                   _self_) ;
   end ;
   else do ;
     tlist = makelist() ;
     rc = fillist('catalog',storage,tlist) ;
     rc = setnitemn(_self_,
                  getnitemn(tlist,'last_used_counter'),
                  'last_used_counter') ;
     rc = dellist(tlist) ;
   end ;
 endmethod ;
 
 
 reset:
   method value 8 ;
 
   rc = setnitemn(_self_,value,'last_used_counter') ;
   rc = savelist('catalog',
                  getnitemc(_self_,'saved_list_name'),
                  _self_) ;
 endmethod ;


 printcur:
   method ;
   rc = getnitemn(_self_,'last_used_counter') ;
   put 'The last used counter value is ' rc ;
 endmethod ;
 
 increm:
   method value 8 ;
   value = getnitemn(_self_,'last_used_counter') + 1 ;
   rc = setnitemn(_self_,value,'last_used_counter') ;
   rc = savelist('catalog',
                  getnitemc(_self_,'saved_list_name'),
                  _self_) ;
 endmethod ;

 
page 96
 
 init:
   staff_list = instance(loadclass(
                 'dgs.toolbox.counter.class')) ;
 
 
   call send(staff_list,'initialise','incstaff','dgs',
             'test') ;
 
   call putlist(staff_list,' ',1) ;
 
 
   client_list = instance(loadclass('counter.class')) ;
   call send(client_list,'initialise','incclient','dgs',
            'test') ;
   call putlist(client_list,' ',1) ;
 return ;
 
 
 reset:
   call send(staff_list,'reset',76) ;
   call putlist(staff_list,' ',1) ;
 
   call send(client_list,'reset',38) ;
   call putlist(client_list,' ',1) ;
 return ;
 
 print:
   call send(staff_list,'print’) ;
   call send(client_list,'print’) ;
 return ;
 
 
 increm:
   call send(staff_list,'increment',new_value) ;
   staff_number = 'A'|| put(new_value,z7.) ;
   put new_value= staff_number= ;
   call putlist(staff_list,' ',1) ;
   call send(client_list,'increment',new_value) ;
   client_number = 'BAD'|| put(new_value,z5.) ;
   put new_value= client_number= ;
   call putlist(client_list,' ',1) ;
 return ;
 

 term:                                                                         
   call send(client_list,'_term_') ;                                           
   call send(staff_list,'_term_') ;                                            
 return ;

page 100

NOTE:	Multiple messages generated, see MSG or LOG 
window.
ERROR: Region too small for object OBJ1.
ERROR: Region fill failure, operation aborted.


page106

 Length widget_name $ 8 output_filename $ 200 ;                                
                                                                               
                                                                               
 _self_ = _self_ ;                                                             
                                                                               
 objlabel:                                                                     
   method ;                                                                    
 
 
     call send(_self_,'_get_current_name_',
          widget_name) ;      
 
 
     if widget_name ne 'GETFNAME' then return ;                                
   
 
     opt_list = makelist() ;                                                   
     rc = insertc(opt_list,
          'Display Filename Dialog',-1) ;                     
     rc = insertc(opt_list,
          'Display Defined Filerefs',-1) ;                    
     selection = popmenu(opt_list) ;                                           
     rc = dellist(opt_list) ;                                                  
                                                                               
     if selection not in (1,2) then return ;     
                              
page 107                                                                               
     if selection = 1 then do ;                                                
        rc=filedialog('saveas',output_filename) ;                              
 
 
        if rc = -1 then return ;                                               
 
        call send(fname,'_set_text_',
             output_filename) ;                 
 
 
        rc = setnitemc(_self_,'FN','FILETYPE') ;                               
 
 
        call send(_self_,'_set_border_title_',
             'Filename To Save To') ;         
     end ;                                                                     
 
     else do ;                                                                 
        listid = makelist() ;                                                  
        rc = curlist(listid);                                                  
        output_filename = filelist() ;                                         
        rc = dellist(listid) ;                                                 
        if output_filename = ' ' then return ;                                 
        call send(fname,'_set_text_',
             output_filename) ;                 
        rc = setnitemc(_self_,'FR','FILETYPE') ;                               
        call send(_self_,'_set_border_title_',
             'Fileref To Save To') ;          
     end ;                                                                     
                                                                               
     call super(_self_,'_object_label_') ;                                     
                                                                               
 endmethod ;


page 108

 filetype:                                                                     
   method fileref_or_filename $ 2;                                             
                                                                               
    fileref_or_filename = 
               getnitemc(_self_,'FILETYPE') ;                       
                                                                               
 endmethod ;


length output_filename $ 200 output_filetype $ 2 ;                            
                                                                              
                                                                              
getfname:                                                                     
  call notify('getfname','get_fn_text',
              output_filename);                    
  if output_filename = ' ' then return ;                                      
  put output_filename= ;                                                      
  call notify('getfname','get_filetype',
            output_filetype) ;                    
  put output_filetype= ;                                                      
return ;                                                                      
                  

/*	Chapter 3	*/             

                                                                                                                    
page 131


 length rc 8 cnm $ 60 currcolor $ 25 ;                                         
                                                                               
 
 dfinit:                                                                       
   infolist = makelist() ;                                                     
                                                                               
 
   call send(_viewer_,'_get_widget_','persbrd',
             nametble_border_id) ;           
   call send(_viewer_,'_get_widget_','dfborder',
             client_border_id) ;            
 
  page 132

   call send(client_border_id,'_get_border_color_',
             currcolor) ;                

 return ;
 
 init:                                                                         
 
  call send(_self_,'_get_record_info_',infolist) ;                            
                                                                               
 
 if getnitemc(infolist,'NEW',1,1,' ') ne 'Y' then do ;                               
      call send(_self_,'_get_column_text_','clientnm',
                cnm) ;                   
      cnm = 'Person Data For ' || cnm ;                                        
   end ;                                                                       
 
   else do ;                                                                   
     cnm = 
  ' ---- New Entry -- No Person Data Available ---- ' ;               
                                                                               
 
 
     client_next = instance(loadclass(
                'dgs.toolbox.counter.class'));           
     call send(client_next,'initialise','clntnext',
               'dgs','client') ;           
     call send(client_next,'increment',value) ;                                
     call send(client_next,'_term_') ;                                         
     clientid = 'C' || put(value,z7.) ;                                        
    end ;                                                                       
 
   call send(nametble_border_id,'_set_border_title_',
             cnm) ;                    
                                                                               
 page 133

   if getnitemc(infolist,'LOCKED') eq 'Y' then do ;                            
     call send(client_border_id,'_set_border_title_',                          
               'This Record Is Not Editable As A User 
Has It Locked') ;        
     call send(client_border_id,'_get_border_color_',
               currcolor) ;              
     call send(client_border_id,'_set_border_color_',
              'red') ;                  
     return ;                                                                  
   end ;                                                                       
   else do ;                                                                   
     call send(client_border_id,'_set_border_title_',
               '') ;                     
     call send(client_border_id,'_set_border_color_',
               currcolor) ;              
   end ;                                                                       
                                                                               
 call send(_viewer_,'_goto_column_','clientnm') ;                            
 return ;                                                                      
                                                                               
  dfterm:                                                                       
     rc = dellist(infolist) ;                                                  
 return ;


page142

 length delchk row rc 3 cid $ 8 filler $ 200 cnm $ 40 
image $ 64;              
                                                                               
 _self_ = _self_ ;                                                             
 _frame_ = _frame_ ;                                                           
 _viewer_ = _viewer_ ;
 
 addrow:        
  method ;                                                                     
     call send(_self_,'_get_row_number_',row) ;                                
 
 
     if row eq . then return ; 
 
                                                                               
     viewid=getnitemn(_self_,'viewerid');                                      
     locals = getniteml(viewid,'_locals_') ;                                   
                                                                               
     if nameditem(locals,'master') then do ;                                   
       master = getnitemn(locals,'master') ;                                   
       call send(master,'_get_current_row_number_',
                 row_numb) ;                 
       if row_numb le 0 then do ;                                              
         _frame_ = getnitemn(getnitemn(_self_,
                   'viewerid'),'_frame_') ;         
         call send(_frame_,'_set_msg_',                                        
          'Select A Master Row Before Adding Row') ;                     
         return ;                                                              
       end ;                                                                   
     end ;                                                                     
                                                                               
 
 
 page 143
 
     call super(_self_,'_add_row_');                                           
 
                                                                               
     if row eq -1 then 
        call send(viewid,'_update_row_dim_') ;                  
                                                                               
 
     collist=makelist();                                                       
     rowlist=makelist();                                                       
     rc=insertn(collist,1);                                                    
     rc=insertn(rowlist,1);                                                    
     call send(viewid,'_goto_column_',collist) ;                               
     call send(viewid,'_set_active_cell_',rowlist,
               collist);                    
     call send(viewid,'_cursor_') ;                                            
     rowlist=dellist(rowlist);                                                 
     collist=dellist(collist);                                                 
 endmethod ;


page 144

length delchk row rc 3 cid $ 8 filler $ 200 cnm $ 40 
image $ 64;              
                                                                              
_self_ = _self_ ;                                                             
_frame_ = _frame_ ;                                                           
 _viewer_ = _viewer_ ;
 
 delrow:                                                                       
   method ;                                                                    
                                                                               
     call send(_self_,'_get_column_text_','nameid',
               cid) ;                      
                                                                               
     _frame_ = getnitemn(getnitemn(_self_,'viewerid'),
              '_frame_') ;             
     if cid eq ' ' then do ;                                                   
        call send(_frame_,'_set_msg_'                                          
         ,'Select A Name Before Using Delete Option') ;                     
        return ;                                                               
     end ;                                                                     
                                                                               
     call send(_self_,'_get_column_text_','name',cnm) ;                        
     delchk = makelist() ;                                                     
     rc = insertc(delchk,'Verify Delete ',1) ;                                 
     rc = setlattr(delchk,'inactive',-1) ;     
     rc = insertc(delchk,'             ',-1) ;                                 
     rc = setlattr(delchk,'inactive',-2) ;
     rc = insertc(delchk,'Delete ' !! cnm,-1) ;                                
     rc = insertc(delchk,'Do Not Delete',-1) ;                                 
 
 
     rc = popmenu(delchk) ;                                                    
     delchk = dellist(delchk) ;     

page 145                                           
                                                                               
     if rc ne 3 then return ;                                                  
 
     phone_model_id = getnitemn(_frame_,
                   'phnetble_model_id') ;                 
 
 
     call send(phone_model_id,'_get_row_number_',
               p_row,1) ;                    
 
 
                                                                               
     do while (p_row ne -1) ;                                                  
        call send(phone_model_id,'_delete_row_') ;                             
        call send(phone_model_id,'_lock_row_',1) ;                             
        call send(phone_model_id,'_get_row_number_',
                  p_row,1) ;                 
     end ;                                                                     
 
                                                                               
 
     call send(_self_,'_get_current_row_number_',
               c_row) ;                      
     call send(_self_,'_lock_row_',c_row);                                     
     call super(_self_,'_delete_row_') ;                                       
 endmethod ;       

page 146                                                            


length delchk row rc 3 cid $ 8 filler $ 200 cnm $ 40 
image $ 64;              
                                                                              
_self_ = _self_ ;                                                             
_frame_ = _frame_ ;                                                           
 _viewer_ = _viewer_ ;
 
 Action1:     /* actions for nametble */                                       
   method actions map row col 8 ;                                              
                                                                               
     link actions ;                                                             
                                                                               
     row = listlen(actions) ;                                                  
     call send(_self_,'_get_current_row_number_',rc) ;                         
                                                                               
     if rc gt 0 then do ;                                                      
         call send(_self_,'_get_column_text_','name',
                   filler) ;                 
         rc = setitemc(actions,getitemc(actions,row) 
          !! ' ( ===>> ' !! trim(filler) !! ' )',row);                         
     end ;                                                                     
     else rc = setlattr(actions,'inactive',row) ;                              
                                                                               
 page 147    
                                                                          
     data_viewer = getnitemn(_self_,'viewerid') ;                              
     actions = insertc(actions,'Edit Text Details',
         -1) ;                       
     map = insertn(map,data_viewer,-1) ;                                   
     map = insertc(map,'client_text_details',-1) ;                             
                                                                               
     actions = insertc(actions,'View Picture',-1) ;                            
     map = insertn(map,data_viewer,-1) ;                                       
     map = insertc(map,'view_picture',-1) ;                                    
                                                                               
 endmethod ;
 
 action2:                                                                      
   method actions map row col 8 ;                                              
 
     link actions ;                                                            
                                                                               
     row = listlen(actions) ;                                                  
     call send(_self_,'_get_current_row_number_',rc) ;                         
                                                                               
     if rc gt 0 then do ;                                                      
       call send(_self_,'_get_column_text_','number',
                 filler) ;                 
       rc = setitemc(actions,getitemc(actions,row) !!                          
             ' ( ===>> ' !! trim(filler) !! ' )',row);                         
     end ;                                                                     
     else rc = setlattr(actions,'inactive',row) ;                              
                                                                               
 endmethod ;                              
 
 actions:                                                                      
 
     rc = clearlist(actions) ;                                                 
     rc = clearlist(map)     ;                                                 
                                                                               
     actions = insertc(actions,'Add New Row   ',-1) ;                          
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_add_row_',-1) ;                                       
                                                                               
     actions = insertc(actions,'Save Row Edits',-1) ;                          
     map = insertn(map,_self_,-1) ;   

page 148                                         
     map = insertc(map,'_save_',-1) ;                                          
                                                                               
     actions = insertc(actions,'Cancel Row Edits',
      -1) ;                        
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_reread_',-1) ;                                        
                                                                               
     actions = insertc(actions,'Delete Row',-1) ;                              
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_delete_row_',-1) ;                                    
                                                                               
 return ;

page 150

length delchk row rc 3 cid $ 8 filler $ 200 cnm $ 40 
image $ 64;              
                                                                              
_self_ = _self_ ;                                                             
_frame_ = _frame_ ;                                                           
 _viewer_ = _viewer_ ;
 
 cpopup:                                                                       
   method menulist sender select 8 ;                                           
 
   _frame_ = getnitemn(_self_,'_frame_') ;                                     
                                                                               
   if (getnitemn(_frame_,'nametble_viewer_id') eq 
          sender) or                   
      (getnitemn(_frame_,'phnetble_viewer_id') eq 
          sender)                      
    then select=popmenu(menulist) ;                                            
 endmethod ;                                                                    


page 151
 
length delchk row rc 3 cid $ 8 filler $ 200 cnm $ 40 
image $ 64;              
                                                                              
_self_ = _self_ ;                                                             
_frame_ = _frame_ ;                                                           
 _viewer_ = _viewer_ ;
 
 phnwhere:                                                                     
  method listid 8 ;                                                            
                                                                               
 
   _frame_ = getnitemn(getnitemn(_self_,'viewerid'),
             '_frame_') ;               

   call super(_self_,'_set_where_',listid) ;                                   
                                                                               
 
   if index(getitemc(listid,1),'INITIAL') then do ;                            
      call send(_frame_,'_set_msg_',                                           
        'Select A Person To View Contact Data') ;                              
      return ;                                                                 
   end ;                                                                       
                                                                               
 

   if sysrc() eq -1 then                                                       
       call send(_frame_,'_set_msg_',
           'No Contact Records Exist');              


 page 152
                                                                              
 endmethod ;
  tabwhere:                                                                     
  method listid 8 ;                                                            
                                                                               
   _frame_ = getnitemn(getnitemn(_self_,'viewerid'),
             '_frame_') ;               
             
 

   where_list = makelist() ;                                                   
   rc = insertc(where_list,'nameid = "INITIAL"') ;                             
   phone_model_id = getnitemn(_frame_,
                    'phnetble_model_id') ;                   
   call send(phone_model_id,'_set_where_
             ',where_list) ;                        
   rc = dellist(where_list) ;                                            

  
   call super(_self_,'_set_where_',listid) ;                                   
if sysrc() eq -1 then                                                       
      call send(_frame_,'_set_msg_',
                'No Person Rows Exist') ;               
 endmethod ;


page 153

 length 
     where_list 8 cid $ 8 cnm $ 60 rc 8 done_yet $ 1 ;                      
   
                                                                             
 dfinit:                                                                       
 
 
  where_list = makelist() ;                                                    
  infolist   = makelist() ;                                                    
  row_list   = makelist() ;                                                    
  col_list   = makelist() ;                                                    
  _frame_  = getnitemn(_viewer_,'_frame_') ;                                   
 
 
  done_yet = 'N' ;                                                             
                                                                               
 return ;                                                                      
                               
 
 init:                                                                         
                                                                               
   if done_yet = 'N' then do ;                                                 
     client_viewer_id = getnitemn(_frame_,
                         'client_viewer_id') ;                
     call send(client_viewer_id,'_get_widget_',
               'phnetble_border_id',           
               phnetble_border_id) ;                                           
 
 
 page 154
                                                                              
     phnetble_model_id = getnitemn(_frame_,
                     'phnetble_model_id') ;              
     call send(phnetble_model_id,
               '_set_event_handler_',_self_,
               'new_person',    
              '_set_where_',phnetble_model_id) ;                               
     done_yet = 'Y' ;                                                          
   end ;                                                                       
                                                                               
   call send(_self_,'_get_record_info_',infolist) ;                            
   
                                                                             
   if getnitemc(infolist,'NEW') eq 'Y' then do ;                               
     client_next = instance(loadclass(
                'dgs.toolbox.counter.class')) ;          
     call send(client_next,'initialise','clntname',
               'dgs','client') ;           
     call send(client_next,'increment',value) ;                                
                                                                               
     call send(client_next,'_term_') ;                                         
     nameid = 'N' || put(value,z7.) ;                                          
                                                                               
     client_model_id = getnitemn(_frame_,
           'client_model_id') ;                  
     call send(client_model_id,'_get_column_text_',
           'clientid',clientid) ;      
                                                                               
   end ;                                                                       
                                                                               
   rc = clearlist(row_list) ;                                                  
   call send(_viewer_,'_get_active_cell_',row_list,
             col_list) ;                 
   if nameditem(row_list,'1') then do ;                                        
     call send(_self_,'_get_column_text_','nameid',cid);                       
     call send(_self_,'_get_column_text_','name',cnm) ;                        
     rc = clearlist(where_list) ;                                              
     rc = insertc(where_list,'nameid = "' !! cid !! 
                  '"') ;                     
     call send(phnetble_border_id,'_set_border_title_',                        
               ' Contact Numbers For ' !! cnm) ;                               
 
 
 
 
     call send(_self_,'_send_event_','new_person',
               where_list) ;                
   end ;                                                                       
 
 
 
 page 155

   else do ;                                                                   
     call send(phnetble_border_id,'_set_border_title_',                        
               'No Person Currently Selected') ;                               
     rc = clearlist(where_list) ;                                              
     rc = insertc(where_list,'nameid = "INITIAL"') ;                           
     call send(_self_,'_send_event_','new_person',
               where_list) ;                
   end ;                                                                       
 return ;                                                                      
               
 
 dfterm:                                                                       
   rc = dellist(where_list) ;                                                  
   rc = dellist(row_list) ;                                                    
   rc = dellist(col_list) ;                                                    
   rc = dellist(infolist) ;                                                    
 return ;


page 155

call send(phnetble_model_id,
          '_set_event_handler_',
          _self_,
          'new_person',    
          '_set_where_',
          phnetble_model_id) ;

page 158

 length rc 8 ;                                                                 
                                                                               
 dfinit:                                                                       
  infolist   = makelist() ;                                                    
  _frame_  = getnitemn(_viewer_,'_frame_') ;                                   
 return ;                                                                      
      
 
 init:                                                                         
    call send(_self_,'_get_record_info_',infolist) ;                           
    if getnitemc(infolist,'NEW') eq 'Y' then do ;                              
       nametble_model_id = getnitemn(_frame_,
                              'nametble_model_id');             
       call send(nametble_model_id,'_get_column_text_',
                'nameid',nameid) ;      
    end ;                                                                      
 return ;                                                                      
                                                                               
                                                                               
 dfterm:                                                                       
   rc = dellist(infolist) ;                                                    
 return ;

page 159

 length name $ 8 client_model_id rc class_id _frame_ 8 
currow 8;               
                                                                               
 _frame_ = _frame_ ;                                                           
                                                                               
 init:                                                                         
                                                                               
  control always ;                                                             
                                                                               
 
   call notify('.','_get_widget_','client',
 	client_viewer_id) ; 
 
 
   client_model_id=getnitemn(client_viewer_id,'dataid') 
;                    
                                                                               
 
   call send(client_viewer_id,'_get_widget_','clientnm',
 	client_name_field) ;   
call send(client_viewer_id,'_get_widget_','dftools',
 	dftools) ;              
   call send(client_viewer_id,'_get_widget_','cntools',
 	cntools) ;              
   call send(client_viewer_id,'_get_widget_','phtools',
 	phtools) ;              
                                                                               
 call notify('client','_get_widget_','nametble',
 	nametble_viewer_id) ;        
 
 
   nametble_model_id = getnitemn(nametble_viewer_id,
 				'dataid') ;  
page 160              
                                                                               
 call notify('client','_get_widget_','phnetble',
 	phnetble_viewer_id) ;        
 
 
   phnetble_model_id = getnitemn(phnetble_viewer_id,
 				'dataid') ;                
                                                                               
   rc = setnitemn(_frame_,nametble_viewer_id,
 	'nametble_viewer_id') ;  
   rc = setnitemn(_frame_,nametble_model_id,
 	'nametble_model_id') ;                      
   rc = setnitemn(_frame_,phnetble_viewer_id,
 	'phnetble_viewer_id') ;           
   rc = setnitemn(_frame_,phnetble_model_id,
 	'phnetble_model_id') ;             
   rc = setnitemn(_frame_,client_model_id,
 	'client_model_id') ;                 
   rc = setnitemn(_frame_,client_viewer_id,
 	'client_viewer_id') ;               
 
 
 
 
   locals = getniteml(nametble_viewer_id,'_locals_') ;                         
   rc = setnitemn(locals,client_viewer_id,'master') ;                          
   locals = getniteml(phnetble_viewer_id,'_locals_') ;                         
   rc = setnitemn(locals,nametble_viewer_id,'master') ;                        
                                                                               
 
 
   call send(nametble_viewer_id,'_get_class_',class_id) 
;                      
                                                                               
   call send(class_id,'_set_method_',
 		'client_text_details',                    
 		'dgs.consult.override.scl','detname') ;  
                         
page 161  
                                                                             
   call send(class_id,'_set_method_','view_picture',                           
             'dgs.consult.override.scl','viewpict') ;                          
                                                                               
 
   call send(client_viewer_id,'_set_instance_method_',
 	'_child_popup_',         
 	'dgs.consult.override.scl','cpopup') ;
 
   call send(nametble_model_id,'_set_instance_method_',
 	'_set_where_',          
 	'dgs.consult.override.scl','tabwhere') ;                          
                                                                               
   call send(nametble_model_id,'_set_instance_method_',
 	'_get_actions_',        
 	'dgs.consult.override.scl','action1') ;                           
                                                                               
   call send(nametble_model_id,'_set_instance_method_',
 	'_add_row_',            
 	'dgs.consult.override.scl','addrow') ;                            
                                                                               
   call send(nametble_model_id,'_set_instance_method_',
 	'_delete_row_',         
 	'dgs.consult.override.scl','delrow') ;                            
                                                                               
   call send(phnetble_model_id,'_set_instance_method_',
 	'_set_where_',          
 	'dgs.consult.override.scl','phnwhere') ;                          
                                                                               
   call send(phnetble_model_id,'_set_instance_method_',
 	'_add_row_',            
 	'dgs.consult.override.scl','addrow') ;                            
                                                                               
   call send(phnetble_model_id,'_set_instance_method_',
 	'_get_actions_',        
 	'dgs.consult.override.scl','action2') ;                           
                                                                               
                                                                               
    call send(dftools,'_gray_','PREVIOUS') ;                                   
    call send(dftools,'_gray_','TOPREC') ;                                     
                                                                               
 
   infolist = makelist() ;                                                     
 return ;                                                                      
 
page 162

 term:                                                                         
   rc = dellist(infolist) ;                                                    
 return ;

 main:                                                                         
   link dftbar ;                                                                 
   link cntbar ;                                                                 
   link phnbar ;                                                                 
 return;

 dftbar:                                                                       
 
  call send(dftools,'_is_modified_',issel) ;                                   
 
  if issel ne 1 then return ;                                                  
 
  call send(dftools,'_get_last_sel_',index,issel,name) ;                       
  call send(client_viewer_id,'_get_record_info_',
 	    infolist) ;                   
 
 
                                                                               
  select (name) ;                                                              
 
    when ('PREVIOUS') do ;                                                     
      if getnitemc(infolist,'NEW') eq 'Y' then                                 
         call 
send(client_viewer_id,'_vscroll_','max',1);                     
      call send(client_viewer_id,'_vscroll_','row',-1) ;                      
    end ;                                                                      
 
 
 
    when ('NEXT')     do ;                                                     
      if getnitemc(infolist,'NEW') eq 'Y' then                                 
         call 
send(client_viewer_id,'_vscroll_','max',1);                     
      call send(client_viewer_id,'_vscroll_','row',1) ;                        
    end ;                                                                      
 
 
 
 
page 163 

    when ('TOPREC')   do ;                                                     
      if getnitemc(infolist,'NEW') eq 'Y' then                                 
         call send(client_model_id,'_save_') ;                                 
      call send(client_viewer_id,'_vscroll_','max',-1) ;                       
    end ;   
 
                                                                   
    when ('BOTREC')   
 	call send(client_viewer_id,'_vscroll_','max',1);
         
    when ('ADDNEW')   do ;                                                     
        call send(client_name_field,'_cursor_') ;                              
        call send(client_model_id ,'_add_row_') ;                              
    end ;                                                                      
 
    when ('SAVEREC')  do ;                                                     
                                                                               
      if getnitemc(infolist,'NEW') eq 'Y' then                                 
         call 
send(client_viewer_id,'_vscroll_','max',1);                     
      else call send(client_model_id,'_save_') ;                               
                                                                               
    end ;                                               
 
 
    when ('CANCCHNG') 
 	call send(client_model_id ,'_reread_') ;                 
    otherwise ;                                                                
  end ;                                                                        
                                                                               
  call send(client_viewer_id,'_get_current_row_number_',
 	currow) ;              
 
  rc = clearlist(infolist) ;                                                   
 
 
 
  call send(client_viewer_id,'_get_dataset_attributes_',
 	infolist) ;            
                        
  if currow eq 1 then do ;                                                     
     call send(dftools,'_ungray_','NEXT') ;                                    
     call send(dftools,'_ungray_','BOTREC') ;                                  
     call send(dftools,'_gray_','PREVIOUS') ;                                  
     call send(dftools,'_gray_','TOPREC') ;                                    
  end ;    

page 164 
                                                                   
  else 
  if currow eq getnitemn(infolist,'number_of_rows') 
  then do ;             
     call send(dftools,'_ungray_','PREVIOUS') ;                                
     call send(dftools,'_ungray_','TOPREC') ;                                  
     call send(dftools,'_gray_','NEXT') ;                                      
     call send(dftools,'_gray_','BOTREC') ;                                    
  end ;                                                                        
  else do ;                                                                    
     call send(dftools,'_ungray_','NEXT') ;                                    
     call send(dftools,'_ungray_','BOTREC') ;                                  
     call send(dftools,'_ungray_','PREVIOUS') ;                                
     call send(dftools,'_ungray_','TOPREC') ;                                  
  end ;                                                                        
                                                                               
  call send(client_name_field,'_cursor_') ;                                    
 return ;
 
 cntbar: 
 
  call send(cntools,'_is_modified_',issel) ;                                   
 
  if issel ne 1 then return ;                                                  
 
 
  call send(cntools,'_get_last_sel_',index,issel,name) ;                       
                                                                               
 
  select (name) ;                                                              
     when ('ADDNAME')   
 	call send(nametble_model_id,'_add_row_') ;              
     when ('SAVENAME')  
 	call send(nametble_model_id,'_save_') ;                 
 
 
 
    when ('CANCNAME')  
 	call send(nametble_model_id,'_reread_') ;               
    when ('DELNAME')   
 	call send(nametble_model_id,'_delete_row_') ;           
    when ('VIEWPICT')  
 	call send(nametble_viewer_id,'view_picture') ;   

page 165    
   
    when ('DETNAME')   
 	call send(nametble_viewer_id,
 		 'client_text_details') ;   
    otherwise ;                                                                
  end ;                                                                        
 return ;

 
 phnbar: 
 
 
 
  call send(phtools,'_is_modified_',issel) ;                                   
 
 
 
  if issel ne 1 then return ;                                                  
 
 
  call send(phtools,'_get_last_sel_',index,issel,name) ;                       
                                                                               
 
 
   select (name) ;                                                              
    when ('ADDNAME')  
 	call send(phnetble_model_id,'_add_row_') ;               
    when ('DELNAME')  
 	call send(phnetble_model_id,'_delete_row_') ;            
    when ('SAVENAME') 
 	call send(phnetble_model_id,'_save_') ;                  
    when ('CANCNAME') 
 	call send(phnetble_model_id,'_reread_') ;                
    otherwise ;                                                                
  end ;                                                                        
 return ;

page 167

 entry listname $ 35 persname $ 25 listid 4 ;                                  
 length rc 4 ;                                                                 
 
init:                                                                         
     rc = clearlist(listid) ;                                                  
 
 
     if cexist(listname) then                                                  
        rc = fillist('catalog',listname,listid) ;                              
                                                                               
     call notify('file','_set_text_',
            '===>> Editing Text For ' !! persname);   
                                                                               
     
     link doete ;                    
 return ;                                                                      
                                                                               
 save:                                                                         
   call notify('viewlist','_get_value_',listid) ;                              
   rc = savelist('catalog',listname,listid) ;                                  
   link doete ;                      
 return ;
 
 canc:                                                                         
   rc = clearlist(listid) ;                                                    
   call notify('viewlist','_clear_') ;                                         
   if cexist(listname) then                                                    
      rc = fillist('catalog',listname,listid) ;                                
                                                                               
   link doete ;
 return ;

 doete:
   rc = insertc(listid,' ',-1) ;                                               
   call notify('viewlist','_set_value_',listid) ;     
   call notify(‘.’,’_refresh_’) ;                         
   call notify('viewlist','_cursor_',listlen(listid),1) ;
 return ;


page 170

 entry nameid $ 8 ;                                                            
                                                                               
 length text $ 64 ;                                                            
imagname:                                                                     
 
   call notify('imagname','_get_text_',text) ;                                 
                                                                               
   if text eq ' ' then return ;                                                
                                                                               
   if index(text,'.IMAGE') then do ;                                           
      if cexist(text) eq 0 then do ;                                           
         _msg_ = 
 'Warning:: IMAGE Catalog Entry Does Not Currently Exist' ;
         return ;                                                              
      end ;                                                                    
   end ;                                                                       
 
   else do ;                                                                   
      if fileexist(text) eq 0 then do ;                                        
        _msg_ =
       'Warning:: The File IMAGE Does Not Currently Exist';         
        return ;                                                              
      end ;                                                                    
   end ;                                                                       
 return ;                                                                      
                                                                               
                                                                               
 term:                                                                         
                                                                               
   if _status_ eq 'C' then return ;                                            
                 
   
 
   call notify('imagname','_get_text_',text) ;    

page 171
                            
   if text eq ' ' then do ;                                                    
     _msg_ = 'Enter an image name or CANCEL' ;                                 
     _status_ = 'R' ;                                                          
     return ;                                                                  
   end ;
                                                               
   tmp = makelist() ;                                                          
   rc = fillist('CATALOG',
        'dgs.images.' !! nameid !! '.slist',tmp) ;           
   rc = insertc(tmp,text,-1) ;                                                 
   rc = savelist('CATALOG',
        'dgs.images.' !! nameid !! '.slist',tmp) ;          
   rc = dellist(tmp) ;                                                         
 return ;


 page 172

 entry image_location $ 64;                                                    
 
 
 init:                                                                         
   if index(image_location,'.IMAGE') ne 0 then                                 
      call notify('image','_read_catalog_',image_location);                   
   else call notify('image','_read_',image_location) ;                         
 return ;                                                                      
 
 
page 173

 The modified General Attributes for this FRAME are:
 length delchk row rc 3 cid $ 8 filler $ 200 cnm $ 40 
image $ 64;              
                                                                               
 _self_ = _self_ ;                                                             
 _frame_ = _frame_ ;                                                           
 _viewer_ = _viewer_ ;                                                         
 
 
 
 addrow:                                                                       
  method ;       
                                                               
     call send(_self_,'_get_row_number_',row) ;                                
 
 
 
                                                                               
     if row eq . then return ; 
 
 
 
 
 
 
 
                                                                               
     viewid=getnitemn(_self_,'viewerid');                                      
     locals = getniteml(viewid,'_locals_') ;                                   
                                                                               
     if nameditem(locals,'master') then do ;                                   
       master = getnitemn(locals,'master') ;                                   
       call send(master,'_get_current_row_number_',
                 row_numb) ;                 
       if row_numb le 0 then do ;                                              
         _frame_ = getnitemn(getnitemn(_self_,
                   'viewerid'),'_frame_') ;         
         call send(_frame_,'_set_msg_',                                        
            'Select A Master Row Before Adding Row') ;                     
         return ;                                                              
       end ;                                                                   
     end ;                                                                     
 
 
 
 
                                                                               
     call super(_self_,'_add_row_');       
                                    
 
page 174 

     if row eq -1 then 
        call send(viewid,'_update_row_dim_') ;                  
                                                                               

    collist=makelist();                                                       
     rowlist=makelist();                                                       
     rc=insertn(collist,1);                                                    
     rc=insertn(rowlist,1);                                                    
     call send(viewid,'_goto_column_',collist) ;                               
     call send(viewid,'_set_active_cell_',rowlist,
               collist);                    
     call send(viewid,'_cursor_') ;                                            
     rowlist=dellist(rowlist);                                                 
     collist=dellist(collist);                                                 
 endmethod ;                                                                   

 phnwhere:                                                                     
  method listid 8 ;                                                            
              
 
 
                                                                  
   _frame_ = getnitemn(getnitemn(_self_,'viewerid'),
            '_frame_') ;               
 
 
 

                                                                         
   call super(_self_,'_set_where_',listid) ;                                   
 
                                                                               
   if index(getitemc(listid,1),'INITIAL') then do ;                            
      call send(_frame_,'_set_msg_',                                           
        'Select A Person To View Contact Data') ;                              
      return ;                                                                 
   end ;                                                                       
 
 
 
 
 
 
page 175
                                                                               
   if sysrc() eq -1 then                                                       
       call send(_frame_,'_set_msg_',
                 'No Contact Records Exist');              
                                                                               
 endmethod ;                                                                   
 
 tabwhere:                                                                     
  method listid 8 ;                                                            
                  
                                                              
   _frame_ = getnitemn(getnitemn(_self_,'viewerid'),
             '_frame_') ;               
 
 
   where_list = makelist() ;                                                   
   rc = insertc(where_list,'nameid = "INITIAL"') ;                             
   phone_model_id = getnitemn(_frame_,
                    'phnetble_model_id') ;                   
   call send(phone_model_id,'_set_where_',where_list) ;                        
   rc = dellist(where_list) ;                                                  
                                                                               
 
   call super(_self_,'_set_where_',listid) ;                                   
                                                                          
 
 if sysrc() eq -1 then                                                       
      call send(_frame_,'_set_msg_',


page 176

          'No Person Records Exist') ;               
 endmethod ;                                                                   
 
 action1:     /* actions for nametble */                                       
   method actions map row col 8 ;                                              
                                                                               
     link actions ;                                                             
                                                                               
     row = listlen(actions) ;                                                  
     call send(_self_,'_get_current_row_number_',rc) ;                         
                                                                               
     if rc gt 0 then do ;                                                      
         call send(_self_,'_get_column_text_','name',
                   filler) ;                 
         rc = setitemc(actions,getitemc(actions,row) !!                        
             ' ( ===>> ' !! trim(filler) !! ' )',row);                         
     end ;                                                                     
     else rc = setlattr(actions,'inactive',row) ;                              
                                                                               
                                                                               
     data_viewer = getnitemn(_self_,'viewerid') ;                              
     actions = insertc(actions,'Edit Text Details',-1) ;                       
     map = insertn(map,data_viewer,-1) ;                                       
     map = insertc(map,'client_text_details',-1) ;                             
                                                                               
     actions = insertc(actions,'View Picture',-1) ;                            
     map = insertn(map,data_viewer,-1) ;                                       
     map = insertc(map,'view_picture',-1) ;                                    
                                                                               
 endmethod ;                                                                   
             
 
 action2:                                                                      
   method actions map row col 8 ;                                              
 
     link actions ;                                                            
                                                                               
     row = listlen(actions) ;                                                  
     call send(_self_,'_get_current_row_number_',rc) ;                         
                                                                               
     if rc gt 0 then do ;                                                      
       call send(_self_,'_get_column_text_','number',
                 filler) ;                 
       rc = setitemc(actions,getitemc(actions,row) !! 

page 177    
                     
             ' ( ===>> ' !! trim(filler) !! ' )',row);                         
     end ;                                                                     
     else rc = setlattr(actions,'inactive',row) ;                              
                                                                               
 endmethod ;                              
 
 actions:                                                                      
     rc = clearlist(actions) ;                                                 
     rc = clearlist(map)     ;                                                 
                                                                               
     actions = insertc(actions,'Add New Row   ',-1) ;                          
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_add_row_',-1) ;                                       
                                                                               
     actions = insertc(actions,'Save Row Edits',-1) ;                          
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_save_',-1) ;                                          
                                                                               
     actions = insertc(actions,'Cancel Row Edits',-1) ;                        
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_reread_',-1) ;                                        
                                                                               
     actions = insertc(actions,'Delete Row',-1) ;                              
     map = insertn(map,_self_,-1) ;                                            
     map = insertc(map,'_delete_row_',-1) ;                                    
                                                                               
 return ;                                     
 
 cpopup:                                                                       
   method menulist sender select 8 ;                                           
 
   _frame_ = getnitemn(_self_,'_frame_') ;                                     
                                                                               
   if (getnitemn(_frame_,'nametble_viewer_id') eq 
          sender) or                   
      (getnitemn(_frame_,'phnetble_viewer_id') eq 
          sender)                      
    then select=popmenu(menulist) ;                                            
 endmethod ;                                                                   
 

 delrow:                                                                       
   method ;                                                                    
                                                                               
     call send(_self_,'_get_column_text_','nameid',cid) 
;                      
                                                                               
     _frame_ = getnitemn(getnitemn(_self_,'viewerid'),
              '_frame_') ;             
  
    if cid eq ' ' then do ;                                                   
        call send(_frame_,'_set_msg_'                                          
          ,'Select A Name Before Using Delete Option') ;                     
        return ;                                                               
     end ;                                                                     
            

page 178   
                                                                
     call send(_self_,'_get_column_text_','name',cnm) ;                        
     delchk = makelist() ;                                                     
     rc = insertc(delchk,'Verify Delete ',1) ;                                 
     rc = insertc(delchk,'             ',-1) ;                                 
     rc = insertc(delchk,'Delete ' !! cnm,-1) ;                                
     rc = insertc(delchk,'Do Not Delete',-1) ;                                 
     rc = setlattr(delchk,'inactive',1) ;                                      
     rc = setlattr(delchk,'inactive',2) ;                                      
                                                                               
     rc = popmenu(delchk) ;                                                    
     delchk = dellist(delchk) ;                                                
                                                                               
     if rc ne 3 then return ;                                                  
 
 
 
 
 
     phone_model_id = getnitemn(_frame_,
                   'phnetble_model_id') ;                 
     call send(phone_model_id,'_get_row_number_',
               p_row,1) ;                    
                                                                               
     do while (p_row ne -1) ;                                                  
        call send(phone_model_id,'_delete_row_') ;                             
        call send(phone_model_id,'_lock_row_',1) ;                             
        call send(phone_model_id,'_get_row_number_',
                  p_row,1) ;                 
     end ;                                                                     
                                                                               
 
 
     call send(_self_,'_get_current_row_number_',c_row) 
;                      
     call send(_self_,'_lock_row_',c_row);                                     
     call super(_self_,'_delete_row_') ;                                       
 endmethod ;                                                                   
  detname: 
   method ;                                                                    
                                                                               
 

 page 179

     call send(_self_,'_get_current_row_number_',
               relative_row_number) ;        
 
     if relative_row_number gt 0 then do ;                                     
       call send(_self_,'_get_column_text_','nameid',
                 cid) ;                    
       call send(_self_,'_get_column_text_','name',cnm) 
;                      
       call display('dgs.consult.edlist.frame',
            'dgs.person.' !! compress(cid)  
             !!  '.source',cnm) ;                                       
     end ;                                                                     
     else call send(_frame_,'_set_msg_',
         'Select A Name Before Using Details Option') ;         
 endmethod ;  


 viewpict:                                                                     
  method ;                                                                     
                                                                               
     call send(_self_,'_get_column_text_','nameid',cid) ;                       
                                                                               
 
 
    if cid eq ' ' then do ;                                                    
       call send(_frame_,'_set_msg_',                                          
           'Select A Name Before Using Picture Option') 
;                 
       return ;   

page 180     
                                                        
    end ;                                                                      
                                                                               
    view_picture = makelist() ;                                                
 
                                                                               
    if cexist('dgs.images.' !! cid !! '.slist') eq 1 
then                      
      rc = fillist('catalog','dgs.images.' !! cid !! 
          '.slist',view_picture) ;  
    rc = insertc(view_picture,'Add Picture',1) ;                               
    rc = popmenu(view_picture) ;                                               
                                                                               
    if rc then image = getitemc(view_picture,rc) ;                             
                                                                               
    view_picture = dellist(view_picture) ;                                     
                                                                               
 
    select (rc) ;                                                              
     when (1) call display('getimage.frame',cid) ;                             
                                                                               
     when (0) ;                                                                
     when (.) ;                                                                
                                                                               
     otherwise do ;                                                            
                                                                               
                                                                                
       if index(image,'.IMAGE') ne 0 then do ; 
          if cexist(image) ne 1 then do ;                                      
            msg = 
       'ERROR: Requested Catalog Image Does Not Exist - 
' 
              !! image; 
            call send(_frame_,'_set_msg_',msg) ; 

page 181                              
            return ;                                                           
          end ;                                                                
       end ;                                                                   
 
 
       else do ;                                                               
          if fileexist(image) ne 1 then do ;                                   
            msg = 
         'ERROR: Requested Image File Does Not Exist - ' 
               !! image;    
            call send(_frame_,'_set_msg_',msg) ;                               
            return ;                                                           
          end ;                                                                
       end ;                                                                   
 
       call display('image.frame',image) ;                                     
                                                                               
     end ;                                                                     
   end ;                                                                       
 endmethod ; 


/*	Chapter 4	*/



page 192

data catlist ;
  length name $ 35
         node 8 
         level 8 ;
  stop ;
run ;

page 195

 length mylist 6 rc id nvalue nodeid 4 node level 8                            
        name text $ 35                                                         
        libname memname objname objtype $ 8 ;                                  
                                                                               
 
 init:                                                                         
  method ;                     
 
 
   call super(_self_,'_INIT_') ;                                               
               
                                                                 
   submit continue sql ;         
      create table catlist as                                                  
       select distinct libname as name length= 35,                             
             1 as level,                                                       
             . as node                                                         
       from dictionary.members                                                 
      where libname not in ('MAPS','LIBRARY') ;                                
  
 
 page 196
                                                                             
      create index node on catlist(node) ;                                     
   endsubmit ;                                                                   
 
 
   dsid = open('catlist','u') ;                                                
   call set(dsid) ;                                                            
                                                                               
   _node = 0 ;                                                                 
   do while(fetch(dsid) ne -1) ;                                               
     _node = _node + 1 ;                                                       
     node = 1000000 * _node ;                                                  
     rc = update(dsid) ;                                                       
   end ;                                                                       
 
  
   name = 'Defined Catalogs' ;                                                 
   level = . ;                                                                 
   node = 1 ;                                                                  
                                                                                
   rc = append(dsid) ;                                                         
 
                                                                               
   rc = close(dsid) ;                                                          
 endmethod ;


page 197

 double:                                                                       
mylist = makelist() ;                                                        
nodedata = getniteml(_self_,'nodedata') ;
 
  text = getnitemc(nodedata,'text');                    
 
  id = getnitemn(nodedata,'id'); 
 
  nvalue = getnitemn(nodedata,'nvalue'); 
 
                                                                               
  if nvalue eq 0 then do ;                                                     
     _msg_ = 'Cannot Collapse The Header Level' ;                              
     return ;                                                                  
  end ;                                                                        
 
 page 198
                                                                               
  if (length(text) - length(compress(text,'.')) 
      ge 2) then do ;                
     _msg_ = 'Cannot Expand Beyond 4 Level Name' ;                             
     return ;                                                                  
  end ;                                                                        
call send(_self_, '_get_owner_', orgid);                                    
  nodeid = getnitemn(_self_,'_nodeid_') ;                                      
                                                                               
 
  if nvalue eq 1 then do ;                                                     

     call send(orgid, '_get_children_', nodeid, 
          'text', mylist);               
 
 
     if listlen(mylist) eq 0 then link lib_expd ;                              
 
 
     else link lib_coll ;                
 
 page 199
                                      
  end ;   
 
  else do ; 
 
 
 
     call send(orgid, '_get_children_', nodeid, 
              'text', mylist);               
 
     if listlen(mylist) eq 0 then link cat_expd ;                              
 
 
     else link cat_coll ;                                                      
  end ;                                                                        
                                                                               
  call send(orgid,'_repopulate_') ;                                            
 
 
 
  rc = dellist(mylist) ;                                                       
 return ;
 
 lib_coll:                                                                     
       outer_node = floor(id/1000000) ;                                        
                                                                               
       submit continue sql ;                                                   
          reset noprint ;                                                      
          delete * from catlist where                                          
           floor(level/1000000) eq &outer_node ;                               
       endsubmit ;                                                             
 return ;                                                                      
                                                                               
 page 200
                                                                              
 lib_expd:                                                                     
        submit continue sql;                                                   
            reset noprint ;                                                    
            create table tmp 
             (where=(memtype="CATALOG")) as                    
             select unique libname,memname,memtype 
                 from dictionary.members     
             where libname eq "&text"                                          
             order by libname,memname   ;                                      
        endsubmit ;                                                            
                                                                               
        dsid = open('catlist','u') ;                                           
        dsidtmp = open('tmp') ;                                                
                                                                               
        call set(dsid) ;                                                       
        call set(dsidtmp) ;                                                    
                                                                               
        node = id ;                                                            
        level = id ;                                                           
                                                                               
        do while(fetch(dsidtmp) ne -1) ;                                       
           node = node + 5000 ;                                                
           name  = compress(text || '.' ||
                   memname);                          
           rc = append(dsid) ;                                                 
        end ;                                                                  
                                                                               
        rc = close(dsid) ;                                                     
        rc = close(dsidtmp) ;                                                  
 return ;                                                                      
                                                                               
 cat_expd:                                                                     
        libname = scan(text,1) ;                                               
        memname = scan(text,2) ;                                               
                                                                               
        submit continue sql ;                                                  
          reset noprint ;                                                      
          create table 
             tmp(where=(memtype="CATALOG")) as 
 
            select libname,memname,objname,
                   objtype,memtype from                
               dictionary.catalogs                                             
             where libname eq "&libname" and                                   
                   memname eq "&memname"                                       
          order by libname,memname,objtype,
                   objname;                         
        endsubmit ;     

                                                       
page 201
                                                                               
        dsid = open('catlist','u') ;                                           
        dsidtmp = open('tmp') ;                                                
                                                                               
        call set(dsid) ;                                                       
        call set(dsidtmp) ;                                                    
                                                                               
        node = id ;                                                            
        level = id ;                                                           
                                                                               
        do while(fetch(dsidtmp) ne -1) ;                                       
           node = node + 1 ;                                                   
           name  = compress(text || '.' || objname 
                   || '.' || objtype) ;        
           rc = append(dsid) ;                                                 
        end ;                                                                  
                                                                               
        rc = close(dsid) ;                                                     
        rc = close(dsidtmp) ;                                                  
 return ;                                                                      
                                                                               
 cat_coll:                                                                     
       submit continue sql ;                                                   
          reset noprint ;                                                      
          delete * from catlist where level eq 
&id;                           
       endsubmit ;                                                             
 return

page 203

 postinit:                                                                     
   method ;                                                                    
 
    call super(_self_,'_postinit_') ;                                          
    call send(_self_,'_add_drag_rep_','CATDRAG') ;                             
    call send(_self_,'_enable_drag_drop_site_') ;                              
 endmethod ;
 
 getdata:                                                                      
   method  rep op $ 20 data x y 8 ;                                            
 
 
 page 204

   if rep eq 'CATDRAG' then do ;                                               
 
     mylist = makelist() ;                                                     
 
 
 
     call send(_self_, '_get_owner_', orgid);                                 
 
 
     nodeid=getnitemn (_self_, '_nodeid_');                                    
 
     call send(orgid, '_get_current_', nodeid, 
               'text id nvalue', mylist);     
 
 
 
     text=getnitemc (mylist, 'text');                                          
     id  =getnitemn (mylist, 'id');                                            
     node=getnitemn (mylist, 'nvalue');                                        
 
                                                                               
     rc = setnitemc(data,text,'TEXT') ;                                        
     rc = setnitemn(data,id,'ID') ;                                            
     rc = setnitemn(data,node,'NODE') ;                                        
     rc = dellist(mylist) ;                                                    
   end ;                                                                       
                                                                               
 
   call super(_self_,'_GET_DRAG_DATA_',rep,op,
              data,x,y) ;                      
 endmethod ;

page 205

 startd:       /* _START_DRAG_ override */                                     
   method x y 8 ;  
 
 
                                                             
     call send(_self_,'_set_background_color_',
               'yellow') ;                     
  
                                                                               
     text = getnitemc(getniteml(_self_,'textval'),
            '1') ;                       
 
                                                                              
    call send(_self_, '_get_owner_', orgid);                                 
 
 
 
     if index(text,'.') eq 0 then 
       call send(orgid,'_broadcast_','GRAY',rc,
            'LIB') ;                        
 
 
page 206
 
     else if scan(text,3) eq ' ' then 
       call send(orgid,'_broadcast_','GRAY',rc,
            'CAT') ;                        
 
 
 
     else call send(orgid,'_broadcast_','GRAY',rc,
            scan(text,4)) ;
 
  endmethod ; 

endd: 
   method rep op $ 20 data 8 code $ 20 ;                                       
 
 
      call send(_self_,'_set_background_color_',
                'inherit') ;                   
 
      call send(_self_, '_get_owner_', orgid);                                  
 
 
      call send(orgid,'_broadcast_','GRAY',rc,
                '+++') ;                         
 
 endmethod ;    

page 209                                                               

 data sasuser.imagedef ;
 
  length name $ 8 
 
 
        label $ 40
 
        level 
 
         node 8 
 
   process $ 200    ;
 
   level = 1 ; 
   node  = 1 ;
 
 
   process = '-FRAME-SCL-HELP-RESOURCE-CBT-PROGRAM-
MENU-CAT-/BUILD' ;
 
   label='        Build Entry' ;
 
 
   name  = 'BUILD' ; 
 
 
 
   output ;

 page 210

   process = '-ENT-CAT-/KILLENT' ;
   label='       Delete Entry';
   name  = 'DELETE' ;
   output ;
   process = '-LIB-/DEALLOC' ;
   label='De-allocate Library';
   name  = 'OPTRSET' ;
   output ;
   process = '-FRAME-SCL-HELP-CBT-PROGRAM-/TEST';
   label='       Testaf Entry' ;
   name  = 'INSTALL' ; 
   output ;
   process = '-FRAME-SCL-HELP-CBT-PROGRAM-/BROWSE';
   label='       Browse Entry' ;
   name  = 'BROWSE' ; 
   output ;
   process = '-FRAME-SCL-HELP-CBT-PROGRAM-
/COMPILE';
   label='      Compile Entry' ;
   name  = 'GENCODE' ; 
   output ;
   process = '-FRAME-SCL-HELP-CBT-PROGRAM-/AF';
   label='      Execute Entry' ;
   name  = 'GENCODE' ; 
   output ;
   process = '-FRAME-RESOURCE-/SYNC';
   label=' Synchronise Entry' ;
   name  = 'GENCODE' ; 
   output ;
 run ;

page 212

 responto:                                                                     
   method rep op $ 20 data 8 code $ 20 ;                                       
                                                                               
 

 call send(_self_,'_set_background_color_',
             'yellow') ;                       
 
 
 endmethod;
 respoff:                                                                      
   method rep op $ 20 data 8 code $ 20 ;                                       
 
 
                                                                               
   call send(_self_,'_set_background_color_',
             'cyan') ;                         
                                                                               
 
 endmethod ;

 page 213

 postimge:                                                                     
   method ;                                                                    
 
    call super(_self_,'_postinit_') ;                                          
 
 
 
    mylist = getniteml(_self_,'nodedata') ;                                    
 
                                                                               
    drop_method= 
       scan(getnitemc(mylist,'cvalue'), 2,'/') ;                                                                                                   
    call send(_self_,'_set_instance_method_',
              '_drop_',                         
              'sasuser.book17.orgover.scl',
              drop_method);                             
                                                                               
 
    call send(_self_,'_add_drop_rep_',
              'CATDRAG');                             
 
    call send(_self_,'_enable_drag_drop_site_');                              
                                                                               
  
    call send(_frame_,'_get_widget_','catent',
              chart) ;                         
 
 
 
    call send(chart,'_add_receiver_',_self_) ;                                 
 
 
 
    call send(_self_,'_set_instance_method_',
       '_receive_',                      
       'sasuser.book17.orgdnd.scl','imagerec') ;                               
 
 endmethod ;


page 217

 imagerec: 
 method msg $ selection 8 value $ sender 8;
mylist = makelist() ;                                                       
 
   call send(_self_, '_get_owner_', orgid);                                   
 
 
   nodeid=getnitemn (_self_, '_nodeid_');                                      
 
 
   call send(orgid, '_get_current_', nodeid,
              'cvalue', mylist);                
type=scan(getnitemc (mylist, 'cvalue'),1,'/');                              
 
 
   rc = dellist(mylist) ;                                                      
 
 
 page 218
                                                                              
   if index(type,'-' || value || '-') or                                       
      (value not in ('+++' 'CAT' 'LIB') & 
             index(type,'ENT'))                   
   then do ;                                                                   
 
 
      call send(_self_,'_set_border_color_',
                'yellow') ;                        
      call send(_self_,'_enable_drag_drop_site_') 
;                            
   end ;                                                                       
 
 
 
   else do ;                                                                   
      call send(_self_,'_set_border_color_',
                'cyan');                          
      call send(_self_,
          '_disable_drag_drop_site_');                           
   end ;                                                                       
 
 
   call super(_self_,'_receive_',msg,selection,
              value,sender) ;                 
 endmethod ;

page 220

 build:                                                                        
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
   text = getnitemc(data,'TEXT') ;                                             
   call build(text) ;                                                          
   call send(_frame_,'_set_msg_','Build Of ' !! 
              text !! ' Completed') ;        
 endmethod ;
 
 killent:                                                                      
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
   text = getnitemc(data,'TEXT') ;                                             
  
                                                                              
   select(popmenu(getnitemn(envlist('L'),'KILL'),
          5,x,y)) ;                     
     when (1) ;                                                                
     otherwise return ;                                                        
   end ;                                                                       
                                                                               
   rc = delete(text,'catalog') ;                                               
 
 
                                                                               
   if scan(text,4) ne ' ' then                                                 
   submit continue sql ;                                                       
      delete * from catlist where name eq "&text" ;                            
   endsubmit ;                                                                 
   else                                                                        
   submit continue sql ;                                                       
      delete * from catlist where                                              
        scan(name,1) eq scan("&text",1) &                                      
        scan(name,2) eq scan("&text",2) ;                                      
   endsubmit ;                                                                 
 
 
   call send(_frame_,'_get_widget_','catent',
             catent);                         
   call send(catent,'_repopulate_') ;                                          
                                                                               
   call send(_frame_,'_set_msg_','Delete Of ' !!
              text !! ' Completed') ;       
 endmethod ;


 page 221

 dealloc:                                                                      
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
   text = getnitemc(data,'TEXT') ;                                             
   id   = getnitemn(data,'ID') ;                                               
                                                                               
   if text in ('WORK','SASHELP','SASUSER') then do;                           
     call send(_frame_,'_set_msg_',
             'You Cannot De-Allocate This Libref');     
     return ;                                                                  
   end ;                                                                       
   
select(popmenu(getnitemn(envlist('L'),'DEALLOC'),
          5,x,y)) ;                  
     when (1) ;                                                                
     when (2) return ;                                                         
     otherwise return ;                                                        
   end ;                                                                       
                                                                               
   rc = libname(text) ;                                                        
                                                                               
   submit continue sql ;                                                       
      delete * from catlist where name 
       like "&text%" ;
   endsubmit ;                                                                 
 
 
                                                                               
   call send(_frame_,'_get_widget_','catent',
             catent) ;                         
   call send(catent,'_repopulate_') ;                                          
                                                                               
   call send(_frame_,'_set_msg_',
      'De-Allocation Of ' !! text !! ' Completed');
 endmethod ;

page 222

 browse:                                                                       
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
                                                                               
   text = getnitemc(data,'TEXT') ;                                             
   call build(text,'browse') ;                                                 
   call send(_frame_,'_set_msg_','Browse Of ' !!
              text !! ' Completed') ;       
 endmethod ;
 
 compile:                                                                      
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
                                                                               
   text = getnitemc(data,'TEXT') ;                                             
 
 
 select(popmenu(getnitemn(envlist('L'),'COMPILE'),
           5,x,y)) ;                  
     when (1) /* no debug */ option= 'debug off' ;                             
     when (2) /*    debug */ option= 'debug on' ;                              
     otherwise option = 'debug off' ;                                          
   end ;                                                                       
                                                                               
   call execcmdi(option) ;                                                     
   call build(text,'compile') ;                                                
   call send(_frame_,'_set_msg_',                                              
             'Compile Of ' !! text !! ' Completed '
             !! option) ;               
 endmethod;

 sync:                                                                         
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
                                                                               
   text = getnitemc(data,'TEXT') ;                                             
   submit continue ;                                                           
     proc build c=&text batch ;                                                
       sync ;                                                                  
     run ;                                                                     
   endsubmit ;                                                                 
   call send(_frame_,'_set_msg_',
              'Sync Completed ');                          
 endmethod ;

 page 223

 af:                                                                           
   method rep op $ 20 data 8 from $ 20 x y 8 ;                                 
                                                                               
   text = getnitemc(data,'TEXT') ;                                             
   select(popmenu(getnitemn(envlist('L'),'AFRUN'),
          5,x,y)) ;                    
     when (1) option=' sclprof=yes' ;                      
     when (2) option= _blank_ ;                             
     otherwise option = _blank_ ;                                              
   end ;                                                                       
   call execcmdi('afa c= ' !! text !! option) ;                                
 endmethod ;                                                                   
 
page 226

 entry new_lib_name $ 8 ;
 
 
 length new_dir_name $ 200;
 
 init:                                                                         
   call notify('lib_name','_cursor_') ;                                        
 return;
 
 
 lib_name:                                                                     
 
 
   call notify('lib_name','_get_text_',new_lib_name) ;                         
   call notify('lib_name','_erroroff_') ;                                      
        
                                                                       
   if sasname(new_lib_name) eq 0 then do ;                                     
     call notify('lib_name','_erroron_') ;                                     
     call notify('.','_set_msg_',
        'Error: The Libref Is Not A Valid SAS Name') ;
     call notify('lib_name','_cursor_') ;                                      
   end ;                                                                       
 return ;  
                                                                   
 newlib:                                                                       
 
   if error(lib_name) then return ;                                            
                                                                               
 
   call notify('newlib','_erroroff_') ;                                        
   call notify('newlib','_get_text_',new_dir_name) ;                           
 
 
   if libname(new_lib_name,'"' || new_dir_name || '"')
    then do ;               
     call notify('.','_set_msg_',sysmsg()) ;                                   
     call notify('newlib','_erroron_') ;                                       
     call notify('newlib','_cursor_') ;                                        
     return ;                                                                  
   end ;                                                                       
                                                                               
 return ;


page 227

 term:                                                                         
 
   if _status_ eq 'C' then new_lib_name = _blank_ ;                            
   else do ;                                                                   
 
     if new_lib_name eq _blank_ or 
        new_dir_name eq _blank_ then do ;           
       call notify('.','_set_msg_',
             'ERROR: Please Enter Both Fields') ;        
 
 
       _status_ = 'R' ;                                                        
     end ;                                                                     
   end ;                                                                       
 return ;
 
 dialog:               
   rc = filedialog('library',new_dir_name,'') ;                                
   if new_dir_name eq ' ' then return ;                                        
   call notify('newlib','_set_text_',new_dir_name) ;                           
                                                                               
   link newlib ;                                                               
 
 
 return ;  
                                                                    
 page 232

 length text $ 35 
        rc 4 ;                                                       
 
 _frame_ = _frame_ ;                                                           
                                                                               
 init:                                                                         
 
   call notify('.','_set_instance_method_',
       '_postinit_',                       
       'sasuser.book17.orgdnd.scl','framepst') ;                               
 
                                                                               
   help_menu = makelist() ;                                                    
   rc = insertc(help_menu,'Field Help ',1) ;                                   
   rc = insertc(help_menu,'Screen Help',2) ;                                   
   rc = insertc(help_menu,'           ',3) ;                                   
   rc = insertc(help_menu,'Exit       ',4) ;                                   
   rc = setlattr(help_menu,'INACTIVE',3) ;                                     
                                                                               
   kill = makelist() ;                                                         
   rc = insertc(kill,'Delete ',1) ;                                            
   rc = insertc(kill,'Do Not Delete',2) ;                                      
   rc = setnitemn(envlist('L'),kill,'KILL') ;                                  
                                                                               
   _dealloc = makelist() ;                                                     
   rc = insertc(_dealloc,'De-Allocate Libref ',1) ;                            
   rc = insertc(_dealloc,'Do Not De-Allocate ',2) ;                            
   rc = setnitemn(envlist('L'),_dealloc,'DEALLOC');                           
  
   compile = makelist() ;                                                      
   rc = insertc(compile,'Do Not Use Debugger',1) ;                             
   rc = insertc(compile,'Use Debugger',2) ;                                    
   rc = setnitemn(envlist('L'),compile,'COMPILE') ;                            
             
                                                                   
   afrun   = makelist() ;                                                      
   rc = insertc(afrun,'Use SCL Profiler',1) ;                                  
   rc = insertc(afrun,'No Profiler',2) ;                                       
   rc = setnitemn(envlist('L'),afrun,'AFRUN') ;                                
                                                                               
   message_list = makelist() ;                                                 
   rc = insertc(message_list,'View Message Window'
                ,1) ;                        
   rc = insertc(message_list,'View Log Window',2) ;                            
   rc = insertc(message_list,
                'Clear Message Window',
                 3) ;                       
   rc = insertc(message_list,'Clear Log Window',4);                           
 return ;

 term:                                                                         
   rc = dellist(kill) ;                                                        
   rc = dellist(message_list) ;                                                
   rc = dellist(compile) ;                                                     
   rc = dellist(_dealloc) ;                                                    
   rc = dellist(afrun) ;                                                       
   rc = dellist(help_menu) ;                                                   
 return ;
 
 viewlog:                                                                      
   select (popmenu(message_list,5,8,30)) ;                                     
     when (1) call execcmdi('msg') ;                                                  
     when (2) do ; 
       call wname('aftmpwin') ;                                                
       call execcmdi(
 'log;save work.test.test.source r;next aftmpwin');       
       call wname(getnitemc(_frame_,'NAME')) ;                                 
       rc = preview('copy',
                    'work.test.test.source');                          
       rc = preview('browse',
              'Viewing LOG .. Press PF3 To Exit') ;             
       rc = preview('clear') ;                                                 
       rc = delete('work.test.test.source',
                 'catalog') ;                        
     end ;                                                                     
     when (3) call execcmdi('msg;clear;end') ;                                        
     when (4) call execcmdi('clear log') ;                                            
     otherwise ;                                                               
   end ;                                                                       
 return ;
 
 alloc:                                                                        
   call display('sasuser.book17.allocate.frame',
        libname) ; 
 
 page 234
                                                                              
    if libname ne _blank_ then do ;                                             
     submit continue sql ;                                                     
       select max(node)+1000000 into :newnode                                  
         from work.catlist                                                     
         where level eq 1 ;                                                    
                                                                               
       insert into work.catlist                                                
         values('&libname',1,&newnode) ;                                       
     endsubmit ;                                                               
 
     call notify('catent','_repopulate_') ;                                    
   end ;                                                                       
 return ;

 addnew:                                                                       
 
   call notify('addnew','_get_text_',text) ;                                   
   if text eq _blank_ then return ;                                            
                                                                               
   libname = scan(text,1,'.') ;                                                
   memname = scan(text,2,'.') ;                                                
                    
                                                            
   if index(text,'.') eq 0 then do ;                                           
     _msg_ = 'ERROR: New Entry Not 2 Level Name';          
     return ;                                                                  
   end ;                                                                       
 
                                                                               
                                                                               
   if sasname(libname) eq 0 or 
      sasname(memname) eq 0 then do ;                 
       _msg_ = 'ERROR: New Entry Name is Invalid';                 
       return ;                                                                
   end ;                                                                       
                                                                               
   if cexist(text) eq 1 then do ;                                              
       _msg_ = 'WARNING: Catalog Entry Already 
Exists -- Request Ignored' ;
       return ;                                                                
   end ;  

page 235                                                                     
 
   if libref(libname) ne 0 then do ;                                           
       _msg_ = 'ERROR: The Libname ' || libname ||
               ' Is Not Assigned' ;        
       return ;                                                                
   end ;                                                                       
   call execcmd('end') ;                                                       
   call build(text) ;                                                          
 
 submit continue sql ;                                                       
 
 
     select node into :node                                                    
       from catlist                                                            
       where name = '&libname' ;                                               
                                                                               
     select coalesce(max(node),&node)+5000 into 
            :m_node                        
       from catlist                                                            
       where level eq &node;                                                   
 
 
                                                                               
     insert into work.catlist                                                  
         values('&text',&node,&m_node) ;                                       
    endsubmit ;                                                                
                                                                               
    call notify('catent','_repopulate_') ;                                     
                                                                               
 
    _msg_ = 'Catalog ' || text || ' Created' ;                                 
 
                                                                               
    call notify('addnew','_clear_') ;                                          
                                                                               
 return ;
 
page 236

 help:                                                                         
                                                                               
   select (popmenu(help_menu)) ;                                               
                                                                               
   when (1) call execcmd('helpmode on') ;                                      
   when (2) call execcmd('help') ;                                             
   otherwise ;                                                                 
   end ;                                                                       
 return ;


/*	Chapter 5	*/


page 246

 _self_ = _self_ ;                                                             
 _frame_ = _frame_ ;                    
                                        
 
 length rc 8 message_done $ 1 ;                                                                 
 
                                                                               
 initial:          
method default $ 200 ;         
 
 
page 247
                                            
   call send(_frame_,
        '_set_instance_method_',
        '_main_label_',                   
        'sasuser.tools.err_mess.scl',
        'mainlab') ;                              
           
 
   call send(_self_,'set_default_message',default) ;
 
    call send(_self_,'_set_text_',default) ;         
 endmethod ;


 settext:                                                                      
  method string $ optional=object_id 8;                                        
call send(_self_,'get_message_status',
              message_done) ;
                                                                               
                                                                            
  if message_done eq 'N' then do ;                                          
      call send(_self_,'set_message_status','Y') ;
      call send(_self_,'_clear_') ;                                          
      call super(_self_,'_set_text_',string) ;                               
      if object_id then 
          call send(_self_,'set_cursor_object',
                    object_id) ;
  end ;                                                                     
 
 
page 248
 
 endmethod ;                                                                   
Mainlab:                                                                      
   method ;                                                                    
 
   call super(_self_,'_main_label_') ;                                         
 
   errorclass=loadclass('sasuser.tools.err_mess');                             
   call send(errorclass, '_get_instances_', eclass) ;                          
   message_object = getitemn(eclass,1) ;                                       
   rc = dellist(eclass) ;
 
   call send(message_object,'get_message_status',
               message_done) ;
                                                                               
   if message_done eq 'N' then do ;                  
      call send(message_object,'_clear_') ;   
      call send(message_object,'get_default_message',
                default) ;                                                 
      call send(message_object,'_set_text_',default);
   end ;
         


 
page 249 
                                                                                
   call send(message_object,'set_message_status',
               'N') ;                                                                                    
                                                                             
 
   call send(message_object,'get_cursor_object',
              cursor_object) ;               
   if cursor_object ne 0 then do ;                                             
      call send(cursor_object,'_cursor_') ;                                    
      call send(message_object,'set_cursor_object',
                0) ;                        
   end ;
 
 endmethod ;                                                                   


 Get_msg:                                                                      
  method message_done $ 1 ;                                                    
                                                                               
  message_done =getnitemc(_self_,'message_done') ;                             
                                                                               
 endmethod ;                                                                   
 
 
 set_msg:                                                                      
  method message_done $ 1 ;                                                    
                                                                               
  rc =setnitemc(_self_,message_done,'message_done') ;                          
                                                                               
 endmethod ;
  get_def:                                                                      
  method message $ 200 ;                                                       
                                                                               
  message   = getnitemc(_self_,'default_message') ;                            
                                                                               
 endmethod ;                                                                   
                                                                               
 set_def:                                                                      
  method message $ 200 ;                                                       
                                                                               
  rc = setnitemc(_self_,message,'default_message') ;                           
                                                                               
 endmethod ;


page 250

 get_cur:                                                                      
  method object_id 8 ;                                                         
                                                                               
  object_id = getnitemn(_self_,'next_cursor') ;                                
                                                                               
 endmethod ;                                                                   
                                                                               
 set_cur:                                                                      
  method object_id 8 ;                                                         
                                                                               
  rc = setnitemn(_self_,object_id,'next_cursor') ;                             
                                                                               
 endmethod ;


page 251

/*                                                                            
 This is the setup for SELVAR class.                                    
*/                                                                            
                   
/*
 get a list of variables for the input SAS file (stored on 
 entry in sas_file_name)
*/


page 252
                                                           
  left_listbox = makelist() ;                                                 
  dfile1=instance(
         loadclass('sashelp.fsp.datafile.class'));                   

  varlist=makelist();                                                         
  call send (dfile1, '_setup_', sas_file_name) ;                              
  call send (dfile1, '_load_members_', varlist);                              
  call send(dfile1,'_term_') ;                                                
                                                                              
/*
 populate the leftmost (Available) listbox
*/
                                                                            
  do i=1 to listlen(varlist) ;                                                
    rc = insertc(left_listbox,getnitemc(
          getiteml(varlist,i),'NAME'),-1) ;     
  end ;                                                                       
  rc = dellist(varlist);                                                      
  
/*
 fill the right listbox with all variables, ie assume they 
 start with everything instead of nothing, and empty the 
 left listbox
*/
                                                                            
  keepvars = copylist(left_listbox) ;                                         
  rc = clearlist(left_listbox) ;                                              

/*
  define the lists to display in the two listboxes
*/
                                                                              
  call notify('getvars','_set_var_list_',left_listbox,
              keepvars) ;             
                                                                              
/*                                                                            
 end selvar setup                                                             
*/


page 259
 
 entry sas_file_name $ 17 type $ 4;                                            
length output_filename $ 200 
 
        libname memname $ 8 
 
 
        rc 8 
 
        filetype $ 2            
 
 name format $ 40 
 
 
 
        dummy $ 100 ;                                         
    
 
                                                                            
 _frame_ = _frame_ ;                                                           
 name   = name   ;                                                             
 format = format ;

page 260
 
  Init:                                                                         
 
   if exist('work.__form') then 
      rc = delete('work.__form') ;                   
           
 
   control error ;                                                             
 
 
 
   keepvars = makelist() ;                                                     
 
 
 
   call notify('.','_get_widget_','delimit',
               delimit_object) ;                  
   call notify('wizard','_gray_',2) ;                                          
   call notify('wizard','_gray_',3) ;                                          
   call notify('wizard','_gray_',4) ;                                          
   call notify('wizard','_gray_',5) ;                                          
   call notify('err_mess','initialise',                                        
               'Welcome To The Sysware Export 
Wizard Version 1.1') ;        
  
 
   left_listbox = makelist() ;                                                 
   dfile1=instance(
       loadclass('sashelp.fsp.datafile.class'));                   
   varlist=makelist();                                                         
   call send (dfile1, '_setup_', sas_file_name) ;                              
   call send (dfile1, '_load_members_', varlist);                              
   call send(dfile1,'_term_') ;                                                
do i=1 to listlen(varlist) ;                                                
     rc = insertc(left_listbox,
     getnitemc(getiteml(varlist,i),'NAME'),-1) ;     
   end ;                                                                       
 
 
page 261 

   rc = dellist(varlist);                                                      
                 
 
                                                               
   keepvars = copylist(left_listbox) ;                                         
   rc = clearlist(left_listbox) ;                                              
 
 
   call notify('getvars','_set_var_list_',
              left_listbox,keepvars) ;             
 
                                                                               
    if index(sas_file_name,'.') eq 0 then                                       
       sas_file_name = 'WORK.' || sas_file_name ;                              
   call notify('sasfile','_set_text_',
                sas_file_name) ;                         
   libname = upcase(scan(sas_file_name,1)) ;                                   
   memname = upcase(scan(sas_file_name,2)) ;                                   
 
   delimit1 = 'Hex Char ' || 
               put(rank(','),hex2.) ;                            
 
 
 
 return ;
term:                                                                         
   call notify('makeform','_set_dataset_',' ') ;                               
                                                                               
   rc = dellist(keepvars) ;                                                    
   rc = dellist(left_listbox) ;                                                
                                                                                
   if exist('work.__form')  then 
      rc = delete('work.__form') ;                  
   if exist('work.__formx') then 
      rc = delete('work.__formx') ;                 
 return ;


page 262

 getfname:                                                                     
   call notify('getfname','get_ete_text',
                output_filename) ;                    
   if output_filename = ' ' then return ;                                      
            
 
 
                                                                    
   call notify('wizard','_ungray_',2) ;                                        
   call notify('wizard','_ungray_',3) ;                                        
   call notify('wizard','_ungray_',4) ;                                        
   call notify('wizard','_ungray_',5) ;                                        
 return ;


 
 delimit:                                                                      
   call notify('delimit','_erroroff_') ;                                       
   if input(delimit,2.) ne . then 
      delimit = byte(input(delimit,2.)) ;          
 
 
   if length(delimit) gt 1 then do ;                                           
      call notify('err_mess','_set_text_',                                     
          'You Can Only Use A Single Character As 
A Delimiter',                
          delimit_object) ;                                                    
      call notify('delimit','_erroron_') ;                                     
      delimit1 = ' ' ;                                                         
      return ;                                                                 
   end ;                                                                       
                                                                               
   if delimit in('"',"'",' ','00'x) then do ;                                  
      call notify('err_mess','_set_text_',                                     
          'You Cannot Use Single/Double 
Quote/Space/Null, As A Delimiter',     
          delimit_object) ;                                                    
      call notify('delimit','_erroron_') ;                                     
      delimit1 = ' ' ;                                                         
      return ;                                                                 
   end ;                                                                       

page 263 
                                                                              
   delimit1 = 'Hex Char ' || 
               put(rank(delimit),hex2.) ;                        
 
 return ;                                                                      
__form:                                                                       
                                                                               
  
   call notify('makeform','_set_dataset_',' ') ;                               
 
   if exist('work.__form') then do ;        
      submit ;                                                                 
         create table work.__formx as                                          
           select name label='Variable Name',                                  
                  substr(type,1,1) as type          
                    label='Type' format= $char3.,       
                  length label = 'Length',                                     
                  format label='Variable Format',                              
                  varnum                                                       
         from dictionary.columns                                               
           where libname eq '&libname' 
              and memname eq '&memname'               
              and memtype eq '&type' and name in 
              (                             
      endsubmit ;                                                              
                                                                               
      do traverse = 1 to listlen(keepvars)-1 ;                                 
         element = getitemc(keepvars,traverse) ;                               
         submit ;                                                              
           '&element',                                                         
         endsubmit ;                                                           
      end ;                                                                    
      element = getitemc(keepvars,traverse) ;                                  
      submit continue sql ;                                                    
         '&element' ) ;                                                        
       
page 264   
                                                                      
         create table work.__form as        
           select a.name label='Variable Name',                                
                  coalesce(b.type,a.type) as type                              
                     label='Type' format=char3.,                        
                  coalesce(b.length,a.length) as 
                     length label = 'Length',                                     
                  coalesce(b.format,a.format) as 
                     format label=
                     'Variable Format'                               
             from work.__formx a left join 
                  work.__form b                       
               on b.name eq a.name                                             
         order by varnum ;                                                     
      endsubmit ;                                                              
   end ;                                                                       
   else do ;                                                                   
      submit ;                                                                 
        
 
 
         create table work.__form as
           select name label='Variable Name',                                  
                  substr(type,1,1) as type 
                    label = 'Type' 
                    format = $char3.,    
                  length label = 'Length',                                     
                  format label='Variable Format'                               
           from dictionary.columns                                             
           where libname eq '&libname' 
                 and memname eq '&memname'               
                 and memtype = '&type' 
                 and name in (                              
      endsubmit ;                                                              
                                                                               
      do traverse = 1 to listlen(keepvars)-1 ;                                 
         element = getitemc(keepvars,traverse) ;                               
         submit ;                                                              
           '&element',                                                         
         endsubmit ;                                                           
      end ;                                                                    
                                                                               
      element = getitemc(keepvars,traverse) ;                                  
      submit continue sql ;                                                    
         '&element' ) ;                                                        
      endsubmit ;                                                              
   end ;                                                                       
                                                                               
   call notify('makeform','_set_dataset_',
               'work.__form','EDIT','RECORD',       
               'NOADD') ;                                                      
 
 
                     
page 265  
                                                         
   call notify('makeform',
        '_set_column_attribute_',
        'name',  'protected','Y') ; 
   call notify('makeform',
        '_set_column_attribute_',
        'type',  'protected','Y') ; 
   call notify('makeform',
        '_set_column_attribute_',
        'length','protected','Y') ; 
   call notify('makeform',
        '_set_column_attribute_',
        'format','protected','N') ; 
 return ;                                                                      


 makeit:                                                                       
 
                                                                               
   call notify('getfname','get_filetype',
               filetype) ;                           
                              
 
   if filetype = 'FN' then do ; 
      submit continue ;                                                        
        filename __outfle clear ;                                              
        filename __outfle '&output_filename' 
                lrecl=32767; run ;                
      endsubmit ;                                                              
   
    outfle ='__outfle';                                                      
 
 
 
 
 
 
 
 
 
 
    end ;                                                                      
    else if filetype eq 'FR' then 
       outfle = output_filename;                    
   
 
 
 
page 266 

    else do ;                                                                  
      call notify('err_mess','_set_text_',                                     
          'No Output File Has Been Defined') ;                                 
      return ;                                                                 
    end ;                                                                      
                                                                               
    hex_delimit = "'" || put(rank(delimit),hex2.)
                  || "'" || 'x' ;              
                                                                               
 
    submit continue ;                                                          
       filename catmacs catalog 
            'sasuser.tools.export.source' ;                   
       %include catmacs / nosource2 ;                                             
       filename catmacs clear ;                                                   
  
       %let keep=                                                               
    endsubmit ;                                                                
                                                                               
    do item=1 to listlen(keepvars) ;                                              
      dummy = getitemc(keepvars,item) ;                                           
      submit ;                                                                 
         &dummy                                                                
      endsubmit ;                                                              
    end ;                                                                      
                                                                               
    item = listlen(keepvars) ;                                                                    
                                                                               
    submit ;                                                                   
      ;                                                                        
      %let nvars = &item ;                                                        
      %let delimit = &hex_delimit ;                                            
    endsubmit ;                                                                
 
 
 
                                                                               
    if dohead eq '2' then                                                      
      submit ;                                                                 
        %let header = NAME ;                                                   
      endsubmit ;                                                              
    else                                                                       
    if dohead eq '1' then                                                      
      submit ;                                                                 


page 267

        %let header = NONE ;                                                   
      endsubmit ;                                                              
    else                                                                       
    if dohead eq '3' then                                                      
      submit ;                                                                 
        %let header = LABEL ;                                                  
      endsubmit ;                                                              
                                                                               
    if exist('work.__form') then do ;                                          
      dsid = open('work.__form') ;                                             
      call set(dsid) ;                                                         
      rc = where(dsid,'format ne " "') ;                                       
      if fetch(dsid) ne -1 then do ;                                           
         submit ;                                                              
           %let format=                                                        
         endsubmit ;                                                           
                                                                               
         do while (1) ;                                                        
           submit ;                                                            
             &name &format                                                     
           endsubmit ;                                                         
           rc = fetch(dsid) ;                                                  
           if rc eq -1 then leave ;                                            
         end ;                                                                 
         submit ;                                                              
           ;                                                                   
         endsubmit ;                                                           
      end ;                                                                    
      rc = close(dsid) ;                                                       
    end ;                                                                      
    else submit ;                                                              
           %let format = ;                                                     
         endsubmit ;                                                           
                                                                               
    submit continue ;                                                          
      %let data = &sas_file_name ;                                             
      %let outfle = &outfle ;                                                  
                                                                               
 
   
    %makecsv                                                                 
    endsubmit ;                                                                
 
 
 
    call notify('err_mess','_set_text_',                                       
          'CSV File Has Been Created In ' 
            || output_filename) ;                
 
 
                                                                               
    call notify('showexp','_unhide_') ;                                        
                                                                               
 return ;

page 268

 wizard:                                                                       
call notify('wizard','_get_active_tab_',
               tabid) ;                            
                                                                               
   if tabid eq 1 then do ; 
      call notify('wizard','_gray_',2) ;                                       
      call notify('wizard','_gray_',3) ;                                       
      call notify('wizard','_gray_',4) ;                                       
      call notify('wizard','_gray_',5) ;                                       
   end ;                                                                       
                  
                                                              
   else if tabid eq 3 then link __form ; 
else if tabid eq 5 then do;
 
      if exist('work.__form') ne 0 then                                        
        call notify('makeform','_save_') ;                                     
      else link __form ;                                                       
 
 
 
page 269  
                                                                             
      call notify('showexp','_hide_') ;                                        
 
 
      submit continue sql ;                                                    
         create view varsview as                                               
            select put(name,$8.) || '  ' ||
                   format as varlist                  
            from work.__form ;                                                 
      endsubmit ;                                                              
                                                                               
      call notify('dispdset','_set_text_',
                  sas_file_name) ;                     
      call notify('dispfile','_set_text_',
                  output_filename) ;                   
                                                                               
      call notify('dispvars','_repopulate_') ;                                 
                                                                               
      dummy = delimit ||  ' (' || delimit1 || 
              ')' ;                            
 
      dispoptslist = makelist() ;                                              
                                                                               
      rc = insertc(dispoptslist,dummy,-1)  ;                                   
                                                                               
      if dohead = '1' then                                                     
         rc = insertc(dispoptslist,
              'No Header Line',-1) ;                      
      else if dohead='2' then                                                  
         rc = insertc(dispoptslist,
              'Variables In Header',-1) ;                 
      else if dohead='3' then                                                  
         rc = insertc(dispoptslist,
              'Labels In Header',-1) ;                    
                                                                               
      call notify('dispopts','_set_value_',
                  dispoptslist) ;                     
 
 
 
      call notify('dispopts','_refresh_') ;                                    
  
 
page 270 

     rc = dellist(dispoptslist) ;                                             
                                                                               
   end ;                                                                       
 return ;


 Showexp:                                                                      
    call preview('clear') ;                                                    
    call preview('include',outfle) ;                                           
    call preview('browse','Export File:: ' 
                 || output_filename) ;               
    call preview('clear') ;                                                    
    call preview('close') ;                                                    
 return ;

page 272

create table work.__formx as select name label='Variable Name', 
substr(type,1,1) as type label='Type' format= $char3., length label = 
'Length', format label='Variable Format', varnum from dictionary.columns 
where libname eq 'SASHELP' and memname eq  
   'COMPANY' and memtype eq 'DATA' and name in (                                                                                                                                                                                                          
'LEVEL2',                                                                                                                                                                                                                                                 
'LEVEL4',                                                                                                                                                                                                                                                 
'LEVEL1',                                                                                                                                                                                                                                                 
'DEPTHEAD',                                                                                                                                                                                                                                               
'LEVEL3',                                                                                                                                                                                                                                                 
'JOB1',                                                                                                                                                                                                                                                   
'N' );                                                                                                                                                                                                                                                    
create table work.__form as select a.name label='Variable Name', 

coalesce(b.type,a.type) as type label='Type' format = $char3., 


pages 273 - 275

%macro makecsv ;                                                                                  
                                                                                                  
options missing = '' ;                                                                            
data _null_ ;                                                                                     
                                                                                                  
  length varname $ 8 ;                                                                            
                                                                                                  
  dsid = open("&data(keep=&keep)",'i') ;                                                          
                                                                                                  
  file putline ;                                                                                  
                                                                                                  
  put '%macro putline ; ' ;                                                                       
                                                                                                  
  %do i=1 %to %eval(&nvars-1) ;                                                                   
    varname = "%scan(&keep,&i)" ;                                                                 
    vartype = vartype(dsid,varnum(dsid,varname));                                                 
                                                                                                  
    if vartype = 'C' then                                                                         
       put "'" '"' "'" +1 varname ' +(-1) ' "'" '"' "'" " &delimit" ;                             
    else put varname ' +(-1) ' " &delimit" ;                                                      
  %end ;                                                                                          
                                                                                                  
  varname = "%scan(&keep,&i)" ;                                                                   
  vartype = vartype(dsid,varnum(dsid,varname));                                                   
                                                                                                  
  if vartype = 'C' then                                                                           
     put "'" '"' "'" +1 varname ' +(-1) ' "'" '"' "'" ;                                           
  else put varname ;                                                                              
                                                                                                  
  put '%mend putline ; ' ;                                                                        
                                                                                                  
  file parse   ;                                                                                  
                                                                                                  
  put '%macro parse ; ' ;                                                                         
                                                                                                  
  %do i=1 %to %eval(&nvars-1) ;                                                                   
    varname = "%scan(&keep,&i)";                                                                  
    vartype = vartype(dsid,varnum(dsid,varname));                                                 
    if vartype = 'C' then do ;                                                                    
       put varname '= tranwrd(' varname ',"' "'" '"' ",' ');" ;                                   
       put varname '= tranwrd(' varname ",'" '"' "'" '," ");' ;                                   
       put varname '= tranwrd(' varname ",'" &delimit "'" ",' ');" ;                              
    end ;                                                                                         
  %end ;                                                                                          
                                                                                                  
  varname = "%scan(&keep,&i)" ;                                                                   
  vartype = vartype(dsid,varnum(dsid,varname));                                                   
                                                                                                  
  if vartype = 'C' then do ;                                                                      
       put varname '= tranwrd(' varname ',"' "'" '"' ",' ');" ;                                   
       put varname '= tranwrd(' varname ",'" '"' "'" '," ");' ;                                   
       put varname '= tranwrd(' varname ",'" &delimit "'" ",' ');" ;                              
  end ;                                                                                           
                                                                                                  
  put '%mend parse ; ' ;                                                                          
                                                                                                  
  file labels ;                                                                                   
                                                                                                  
  put '%macro labels ; ' ;                                                                        
                                                                                                  
  %do i=1 %to %eval(&nvars-1) ;                                                                   
    varname = "%scan(&keep,&i)" ;                                                                 
    varlabel = varlabel(dsid,varnum(dsid,varname)) ;                                              
    if varlabel = ' ' then varlabel = varname ;                                                   
    varlabel = tranwrd(varlabel,"'" ,' ') ;                                                       
    varlabel = tranwrd(varlabel,'"' ," ") ;                                                       
    varlabel = tranwrd(varlabel,&delimit ,' ');                                                   
    put "put '" '"' varlabel +(-1) '"' "' " " &delimit @;" ;                                      
  %end ;                                                                                          
                                                                                                  
  varname = "%scan(&keep,&i)" ;                                                                   
  varlabel = varlabel(dsid,varnum(dsid,varname)) ;                                                
  if varlabel = ' ' then varlabel = varname ;                                                     
  varlabel = tranwrd(varlabel,"'" ,' ') ;                                                         
  varlabel = tranwrd(varlabel,'"' ," ") ;                                                         
  varlabel = tranwrd(varlabel,&delimit ,' ');                                                     
  put "put '" '"' varlabel +(-1) '"' "' ;" ;                                                      
                                                                                                  
  put '%mend labels ; ' ;                                                                         
                                                                                                  
  file names  ;                                                                                   
                                                                                                  
  put '%macro names  ; ' ;                                                                        
                                                                                                  
  %do i=1 %to %eval(&nvars-1) ;                                                                   
    varlabel = "%scan(&keep,&i)" ;                                                                
    put "put '" '"' varlabel +(-1) '"' "' " "&delimit @; " ;                                      
  %end ;                                                                                          
                                                                                                  
  varlabel = "%scan(&keep,&i)" ;                                                                  
  put "put '" '"' varlabel +(-1) '"' "';" ;                                                       
                                                                                                  
  put '%mend names ; ' ;                                                                          
                                                                                                  
  rc = close(dsid) ;                                                                              
  stop ;                                                                                          
run ;                                                                                             
                                                                                                  
%include 'parse.dat' ;                                                                            
%include 'putline.dat' ;                                                                          
%include 'labels.dat' ;                                                                           
%include 'names.dat' ;                                                                            
                                                                                                  
data _null_ ;                                                                                     
                                                                                                  
  set &data (keep=&keep) ;                                                                        
                                                                                                  
  format &format ;                                                                                
                                                                                                  
  file &outfle ;                                                                                  
                                                                                                  
  if _n_ eq 1 and "&header" ne "NONE" then do ;                                                   
     if "&header" eq "NAME" then do ;                                                             
       %names ;                                                                                   
     end ;                                                                                        
     else if "&header" eq "LABEL" then do ;                                                       
       %labels ;                                                                                  
     end ;                                                                                        
  end ;                                                                                           
                                                                                                  
  %parse                                                                                          
                                                                                                  
  put %putline ;                                                                                  
                                                                                                  
run ;                                                                                             
                                                                                                  
%mend makecsv ;            

                                                                       
                                   
/*	Chapter 6	*/      


page 279

length _self_ 3 _method_ $ 40 ;

bpinit:
  method ;
      call execcmdi(‘rm;rm describe on') ;
      call super(_self_,_method_) ;
 endmethod ;

page 280

pinit:                                                                        
  method ;                                                                    
      call send(_self_,'_enable_resize_notify_') ;                            
      call super(_self_,_method_) ;                                           
 endmethod ;                                                                  



call send(_frame_,'_enable_resize_notify_') ;


page 281
 
 length region_list nr nc right_FRAME top_FRAME 
        bottom_FRAME widget_list right_widget     
        bottom_widget left_FRAME top_widget left_widget           
        rc 8 ;                                                                 
                                                                               
 resize:                                                                       
   method ;      
                                                               
                                                                               
   widget_list = makelist() ;                                                  
   region_list = makelist() ;                                                  
                                                                               
   
   call send(_FRAME_,'_winfo_','startrow',top_FRAME) ;                        
   call send(_FRAME_,'_winfo_','startcol',left_FRAME) ;                       
   call send(_FRAME_,'_winfo_','numrows',nr) ;                                 
   call send(_FRAME_,'_winfo_','numcols',nc) ;                                 
                                                                               
   right_FRAME  = left_FRAME  + nc - 1 ;                                       
   bottom_FRAME  = top_FRAME  + nr - 1;                                        
                                                                               
 
                                                                               
   call send(_FRAME_,'_get_widgets_',widget_list) ;                            
                                                                               
 
   do rc=1 to listlen(widget_list) ;                                           
     
 
      call send(getiteml(widget_list,rc),
               '_get_region_', region_list) ;         
   
      right_widget= ceil(getnitemn(region_list,'lrx'));                     
      left_widget= floor(getnitemn(region_list,'ulx'));                      
      bottom_widget=ceil(getnitemn(region_list,'lry'));                    
      top_widget = floor(getnitemn(region_list,'uly'));                       
                                                                               
      if right_widget  ge right_FRAME  OR                                      
         bottom_widget  ge bottom_FRAME  OR                                    
         left_widget  le left_FRAME  OR                                        
         top_widget  le top_FRAME                                              
      then do ;                                                                
        if right_widget  gt right_FRAME  then                                  
           right_FRAME  = right_widget  + 1 ;                                  
        if bottom_widget  gt bottom_FRAME  then                                
           bottom_FRAME  = bottom_widget  + 1 ;                                
        if left_widget  lt left_FRAME  then                                    
           left_FRAME  = left_widget  - 1 ;                                    
        if top_widget  lt top_FRAME  then                                      
           top_FRAME  = top_widget  - 1 ;                                      

call send(_FRAME_,'_set_window_size_',                                 
                  top_FRAME ,left_FRAME ,                                      
                  bottom_FRAME ,right_FRAME ) ;                                
      end ;                                                                    
   end ;                                                                       
                                                                               
   rc = dellist(region_list) ;                                                 
   rc = dellist(widget_list) ;                                                 
                                                                               
   call super(_FRAME_,'_resize_') ;                                            
 endmethod ;


page 286

listbox:
.....
call notify(‘extended table widget’,’_NEED_REFRESH_’) ;


page 287

getimage:
  pathname = ‘c:\dir\my.gif’ ;
  tid= imginit(0,'nodisplay') ;                                              
  rc = imgop(tid,'read',pathname,'format=gif') ;                              
  rc = imgop(tid,'write','mailsys.picture.test',
       'format=cat');               
  rc = imgterm(tid) ;
return ;


page 288

init:                                                                         
  path = 'c:\frambook\oops.tif' ;                                             
  imagedat = instance(loadclass('sashelp.fsp.imgdat')) ;                      
  call send(imagedat,'_read_',path,'format=tif') ;                            
  call send(imagedat,'_write_catalog_',
'sasuser.book10.oops') ;               
call send(imagedat,’_term_’) ;
return ;


page 289

 init:                                                                         
   listid = makelist() ;                                                       
   do i=1 to 40 ;                                                              
     rc = insertc(listid,'List Item ' !! put(i,z2.),i) ;                       
   end ;                                                                       
 return ;                                                                      
   
 
 term:                                                                         
   rc = dellist(listid) ;                                                      
   if id then rc = dellist(id) ;                                                          
 return ;                                                                      
       
                                                                         
 delete:                                                                       
 
   id = getniteml(listbox,'ID') ;                                        
if listlen(id) eq 0 then return ;                                           
                                                                               
   
do i=listlen(id) to 1 by -1 ;                                               
     call notify('listbox','_delete_',getitemn(id,i)) ;                          
   end ;                                                                       
 return ;                                                                      
 



page 292

obj1:                                                                         
  text = getniteml(obj1,'TEXT') ;                                             
return ;



af c=libref.catalog.objname.objtype sclprof=yes


page 294

call notify('timer','_set_cursor_shape_',2) ;
endtime = time() + '00:05:00't ;
do until(time() > endtime) ;
    if event() then return ;
end ;


page 295

endtime = time() + '00:05:00't ;
do until(time() > endtime) ;
    put ‘In Loop’ ;
    if event() then return ;
end ;


page 296

term:
  entry_class = loadclass('document.document.entry') ;
  call send(entry_class,'_get_instances_',entry_fields);

  do item_num = 1 to listlen(entry_fields) ;
    rc = clearlist(multi_line_note) ;
    call send(getitemn(entry_fields,item_num),
              '_get_value_',
              multi_line_note);
     if listlen(multi_line_note) ne 0 then do ;
        rc = clearlist(entry_fields) ;
        rc = insertc(entry_fields,
                'Non Blank Fields Exist',-1) ;
        rc = insertc(entry_fields,' ',-1) ;
        rc = insertc(entry_fields,
                'Exit (losing text)',-1) ;
        rc = insertc(entry_fields,'Stay in SDA',-1) ;

        if popmenu(entry_fields) ne 3 then do ;
           _status_ = 'R' ;
           return ;
        end ;
        else goto confirm:
     end ;
  end ;

confirm:

... More term code .. .

return ;


page 297

/* Copyright(c) 1996 by SAS Institute Inc., Cary, NC USA */

/********************************************************************/
/* SCL program associated to a FRAME entry containing a data table  */
/* object named TABLE.  This displays the data set, SASUSER.HOUSES, */
/* which is defined to the data table with the _SET_DATASET_ method */
/* rather than in the Data Table Attributes window.  The column     */
/* labels for the variables in this data set have been altered so   */
/* that they contain a split character, an asterisk, as follows:    */
/*                                                                  */
/*    STYLE     Style of*home                                       */
/*    SQFEET    Square*feet                                         */
/*    BEDROOMS  Number of*bedrooms                                  */
/*    BATHS     Number of*baths                                     */
/*    STREET    Street*address                                      */
/*    PRICE     Asking*price                                        */
/*                                                                  */
/* To have column labels split over multiple lines, you will need   */
/* to override the following Table Data Model methods:              */
/*    _GET_COLUMN_INFO_:  designates what the split character is    */
/*    _GET_COLUMN_DIM_INFO_:  expands the height of the column      */
/*                            label row                             */
/********************************************************************/

init:
   call send(_frame_,'_get_widget_','table',tabid);
   /* Set the data set programmatically rather than in the    */
   /* Data Table attributes window.                           */
   call send(tabid,'_set_dataset_','sasuser.houses','browse');
   call send(tabid,'_display_column_label_','_all_');
   modelid=getnitemn(tabid,'DATAID');
   call send(modelid,'_set_instance_method_','_get_column_info_',
             'sasuser.datatabl.splitlbl.scl','getcoli');
   call send(modelid,'_set_instance_method_','_get_column_dim_info_',
             'sasuser.datatabl.splitlbl.scl','getcdimi');
 return;

page 298

/********************************************************************/
/* If you are naming the table to display in the data table object  */
/* in the Data Table Attributes window, then you will need to use   */
/* the following SCL program in your FRAME entry in place of the    */
/* SCL program listed above.                                        */
/********************************************************************/

init:
   call send(_frame_,'_get_widget_','table',tabid);
   modelid=getnitemn(tabid,'DATAID');
   call send(modelid,'_set_instance_method_','_get_column_info_',
             'sasuser.datatabl.splitlbl.scl','getcoli');
   call send(modelid,'_set_instance_method_','_get_column_dim_info_',
             'sasuser.datatabl.splitlbl.scl','getcdimi');
   /* Close and then reopen the data set so that the method   */
   /* _GET_COLUMN_DIM_INFO_ is executed again.                */
   call send(tabid,'_set_dataset_',' ');
   call send(tabid,'_set_dataset_','sasuser.houses','browse');
   call send(tabid,'_display_column_label_','_all_');
 return;

/********************************************************************/
/* SCL program contained in SASUSER.DATATABL.SPLITLBL.SCL           */
/*                                                                  */
/* _GET_COLUMN_INFO_: designates what the split character is        */
/* _GET_COLUMN_DIM_INFO_: expands the height of the column label row*/
/********************************************************************/

getcoli:
   method rcdvecid 8;
      call super(_self_,'_get_column_info_',rcdvecid);
      call send(rcdvecid,'_set_wrapping_','y','*');
      call send(rcdvecid,'_set_vjust_','bottom');
   endmethod;

getcdimi:
   method coladdr elements subdim height 8 units $ 5 grouplst 8 eod $1;
      call super(_self_,'_get_column_dim_info_',
                   coladdr,elements,subdim,height,units,grouplst,eod );
      if (listlen(coladdr)=0) then
      do;
         units='fit';
      end;
   endmethod;




page 300

  call notify(‘.’,’_get_widget_’,’table’,tabid) ;
  modelid = getnitemn(tabid,'dataid') ;
  call send(modelid,'_set_instance_method_',
            '_get_data_',
            'sasuser.test.traffic.scl','getdata');


page 301

 length actual target $ 12 rc 8 ;                                              
 
 _self_ = _self_ ;                                                             
 
 getdata:                                                                      
 method gddvecid numcols 8;                                                    
 
 call super(_self_,'_get_data_',gddvecid,
             numcols);                             
 
 call send(gddvecid,'_set_index_',2);        
 call send(gddvecid,'_get_text_',target) ;                                     
 call send(gddvecid,'_set_index_',1);        
 call send(gddvecid,'_get_text_',actual) ;                                     
    
      
                                                                       
 if input(actual,12.) lt input(target,12.) then                                
  call send(gddvecid, '_set_color_','orange');                                 
 else                                                                          
  call send(gddvecid, '_set_color_','blue');                                   
 endmethod;                                       


