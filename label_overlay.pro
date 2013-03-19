pro label_overlay, philabel,thetalabel,mollx,molly,coordin,coordout

if (coordin eq coordout) then begin
    code = ''
endif else begin
    code = strlowcase(coordin)+'2'+strlowcase(coordout)
endelse
print,"code",code
phi = philabel                  ; transform coordinates, if necessary
theta = thetalabel                                ;
if (code ne '') then begin
    coortrans,[[philabel],[thetalabel]],ll,code,/lonlat
    phi = reform(ll[*,0])
    sel = where(phi gt 180.)
    if (sel[0] ne -1) then phi[sel] =phi[sel] - 360.
    theta = reform(ll[*,1])
endif
                                ;
                                ; get Mollweide x,y from lon, lat in degrees
                                ;
Mollweide_XY, phi, theta, X, Y
                                ;
                                ; Scale to normalized coordinates
                                ;
mollx = (x +2.)/4.
molly = (y +1.)/2.

return
end
