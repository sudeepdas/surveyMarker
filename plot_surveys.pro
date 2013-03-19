;Time-stamp: <2009-07-13 22:51:07 sudeep>
;AUTHOR: Sudeep Das, Princeton University, 2007-2009
;Used in conjuction with savesurveys.pro 

pro plot_surveys,inputFileName,psFileName,showPossible=showPossible

;+
; NAME: plot_surveys
;
;
;
; PURPOSE:plots survey regions on a mollweide projection of a HEALPix
; sphere using pre-saved regions (IDL savesets) from marksurveys.pro 
;
;
;
; CATEGORY: plotting 
;
;
;
; CALLING SEQUENCE:plot_surveys,'x.dat','test.ps',[/showPossible]
;
;
;
; INPUTS: 
; x.dat - A text file with 5 columns. The columns are:
;         Name_of_healpix_saveset color_Value labelRa, labelDec,labelText
;         (leave labelText empty if you do not want to label a region)

;
; test.ps : the desired output file name
;
; OPTIONAL INPUTS: none
;
;
;
; KEYWORD PARAMETERS:
; showPossible - It applied, marks the possible survey region that can be
;                reached by the telescope
;
;
; OUTPUTS: A PS file with the plot
;
;
;
; OPTIONAL OUTPUTS: None
;
;
;
; COMMON BLOCKS:
;
;
;
; SIDE EFFECTS:
;
;
;
; RESTRICTIONS:
;
;
;
; PROCEDURE:
;
;
;
; EXAMPLE:
;
;
;
; MODIFICATION HISTORY:
;
;-JULY 8, 2009 SUDEEP DAS, PRINCETON UNIVERSITY 



;read wmap Kp2 mask

fits_read_map,'wmap_kp2_r9_mask_3yr_v2',junk,map



labelColors=['black','red','darkgreen','blue','magenta','yellow','cyan','orange','brightgreen','mediumgray',$
             'lightgray','lightgreen','purple','sapgreen','mediummagenta','slategray','darkgray']

;allocate a map
ud_grade,map,map,nside_out=256,order_in='Nested'


nside=nint(sqrt((n_elements(map)/12.)))*1l


readcol,inputFileName,key,color,numline=8,format='(a,a)'
globeColor = color[0]
maskColor=color[1]
labelColor = color[2]
raLabelColor = color[3]
decLabelColor = color[4]
possibleColor = color[5]
gridColor = color[6]
bgColor = color[7]
print, maskColor
idx = where(map ne 0.)
idy = where(map eq 0.)
map[idy] = (where(labelColors eq maskColor))[0]

map[idx] = (where(labelColors eq globeColor))[0]
;map[0]=0.
;project onto Mollweide map from G-> G
reproj_healpix,map,map2,coord=1,project=1,size=3

map[*]=0.


readcol,inputFileName,survey,value,rax,decx,labelx,format='(a,a,f,f,a)',skipline=8
print, survey,value
sz = size(survey)
print, sz(1)

for i =0,sz(1)-1 do begin 
    restore,survey(i),/verbose
    idx = where(labelColors eq value(i))
    print, "idx", idx
    map[ip] = idx;colorVals(idx)
endfor
map0=map*0.
map0[*]=0.
load_ed_colors,mycolors
if keyword_set(showPossible) then begin
    restore,'ACTpossible256nest',/verbose
    map0[ip]=(where(labelColors eq possibleColor))[0]
endif

reproj_healpix,map,map3,coord=4,project=1,size=3 ;'C'->'G'
;clear out overlapping areas in WMAP map
idx = where(map3 ne 0.)
map2[idx]=0.

reproj_healpix,map0,map4,coord=4,project=1,size=3 ;'C'->'G'



newmap=map2+map3
if keyword_set(showPossible) then begin 
    gCol = (where(labelColors eq globeColor))[0]
    idx = where((newmap eq gCol) and  (map4 ne 0))
    newmap[idx]=(where(labelColors eq possibleColor))[0]
endif

;for bgColor
map0[*]=1.0
reproj_healpix,map0,map5,coord=4,project=1,size=3 ;'C'->'G'
idx = where(map5 eq 0)
newmap[idx]  = (where(labelColors eq bgColor))[0]
nlon=13
nlat=13
lon=findgen(nlon)*360./(nlon-1)
lat=findgen(nlon)*180./(nlon-1)-90.
load_ed_colors,mycolors
grid_overlay_sudeep2,image=newmap,ps=psFileName,lon=lon,lat=lat,grcoord='C',/leave_ps_open,$
  color=(where(labelColors eq gridColor))[0],ct=27

hrtodeg=360./24.
label_overlay,rax,decx,mollx,molly,'C','G'

load_ed_colors,mycolors
xyouts,mollx,molly,' '+labelx,/norm,charthick=3,charsize=1.0,color=(where(labelColors eq labelColor))[0]

;label the grids now
;start with RA
lat0=- replicate(360./(nlon-1),nlat-1)
lon0= lon[0:nlon-2]
labelRA=sigfig(lon,3)+'!u o!n'
labelRA[9]=' '
label_overlay,lon0,lat0,mollx,molly,'C','G'
load_ed_colors,mycolors
xyouts,mollx,molly,labelRA,/norm,charthick=3,charsize=0.8,color=(where(labelColors eq raLabelColor))[0]

;start with RA
lat0= 2*replicate(360./(nlon-1),nlat-1)
lon0= lon[0:nlon-2]
labelRA=sigfig(lon0,3)+'!u o!n'
labelRA[9]=' '

label_overlay,lon0,lat0,mollx,molly,'C','G'
load_ed_colors,mycolors
xyouts,mollx,molly,labelRA,/norm,charthick=3,charsize=.8,color=(where(labelColors eq raLabelColor))[0]
;now do dec
lon0= replicate(270.,nlon-1)/1.
lat0= lat[0:nlon-2]
labeldec=sigfig(lat0,3)+'!u o!n'
label_overlay,lon0,lat0,mollx,molly,'C','G'
load_ed_colors,mycolors
xyouts,mollx,molly,labeldec,/norm,charthick=3,charsize=.8,color=((where(labelColors eq decLabelColor)))[0] ,orientation=55
;add a label for the months
;monthra=[250,120]
;monthdec=[-53,-53]
;monthlabel=['June','Feb']
;label_overlay,monthra,monthdec,mollx,molly,'C','G'
;xyouts,mollx,molly,monthlabel,/norm,charthick=3,charsize=1,color=mycolors[5]
;personalize
xyouts,0.01,0.02,'!Z(X00A9)' + ' Sudeep Das for the ACT collaboration',/norm,charsize=0.8,color=(255-(where(labelColors eq bgColor))[0])
device,/close


end



