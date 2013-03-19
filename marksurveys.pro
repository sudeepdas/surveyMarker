
;Feb 20,2007: Sudeep Das

pro marksurveys,nside,thetalimits,philimits,ip,nested=nested,degrees=degrees,astro=astro
;+
; NAME: marksurveys
;
;
;
; PURPOSE: To return the pixels that fall within a rectangle defined
; by the thtea and phi limits on a Healpix sphere of given nside
;
;
;
;
; CALLING SEQUENCE: marksurveys,nside,lonlimits,latlimits,ip,[/nested,/astro];
;
;
; INPUTS: Nside of the healpix map
;         Thetalimits: Limits on the latitude [0-pi]
;         Philimits: Limits on the longitude [0-2pi]
;         If /degrees is set, these values are to be in degrees.
;         If /astro is set, degrees are assumed and limits for theta
;         are [-90:90] and that for phi are [0:360]
; OPTIONAL INPUTS:
;
;
;
; KEYWORD PARAMETERS: nested: returns the pixel indices in HealPix
; nested format. astro: see above, degrees: see above
;
;
;
; OUTPUTS: retuns the list of pixels inside the queried rectangle in 'ip'
;
;
;
; EXAMPLE: To query a strip of ra=[100,120] and dec=[-56,-54] at Nside 512
; 
; markesurveys,512,dec,ra,/astro
;
; MODIFICATION HISTORY: 02/20/2007- File created
;
;-
if(keyword_set(astro) and keyword_set(degrees)) then begin
print,'Cannot call with both degrees and astro: see header'
return
endif

If keyword_set(degrees) then begin
    thetalimits=thetalimits*!pi/180.
    philimits=philimits*!pi/180.
endif

if keyword_set(astro) then begin
    thetalimits=(90.-thetalimits)*!pi/180.
    philimits=philimits*!pi/180.
endif

;check limits
thetalim=minmax(thetalimits)
philim=minmax(philimits)

if(thetalim[0] lt 0 or thetalim[1] gt !pi or philim[0] lt 0 or philim[1] gt 2*!pi) then begin
print,'Invalid theta or phi range'
return
endif

npix=12l*nside^2
angres=sqrt(4*!pi/npix)/2. ;half the avg separation betweeen pixels

ntheta=nint((thetalim[1]-thetalim[0])/angres,/long)
nphi=nint((philim[1]-philim[0])/angres,/long)

dtheta=(thetalim[1]-thetalim[0])/(ntheta-1)
dphi=(philim[1]-philim[0])/(nphi-1)
print,ntheta,nphi,ntheta*nphi
ip=lonarr(ntheta*nphi)
j=0l
for itheta=0l,ntheta-1 do begin
    theta=thetalim[0]+itheta*dtheta
    for iphi=0l,nphi-1 do begin
        phi=philim[0]+iphi*dphi
        if keyword_set(nested) then begin
            ang2pix_nest,nside,theta,phi,ipnow
        endif else begin
            ang2pix_ring,nside,theta,phi,ipnow
        endelse
        
        ip[j]=ipnow
        j=j+1l
    endfor
    
endfor

end
