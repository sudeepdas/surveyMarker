;Time-stamp: <2009-07-10 00:02:07 sudeep>
;21 Feb 2007: Sudeep Das
pro savesurveys,which,nside
;creates IDL savesets of Nested Healpix pixel numbers in  queried surveys.
nside=long(nside)
case which  of
    'ACT_SGSS' : begin
        declim=[-54,-56]
        ralim=[0,120]
        marksurveys,nside,declim,ralim,ip1,/astro,/nested
        declim=[-54,-56]
        ralim=[250,360]
        marksurveys,nside,declim,ralim,ip2,/astro,/nested
        ip=[ip1,ip2]
        save,file='ACT_SGSS'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'ACT_NGES' : begin
        declim=[-2,+2]
        ralim=[120,250]
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file='ACT_NGES'+trim(nside,2)+'nest',ip,/verbose
    end 
    
    'ACT_SGES' : begin
        declim=[-2,+2]
        ralim=[0,70]
        marksurveys,nside,declim,ralim,ip1,/astro,/nested
        declim=[-2,+2]
        ralim=[300,360]
        marksurveys,nside,declim,ralim,ip2,/astro,/nested
        ip=[ip1,ip2]
        save,file='ACT_SGES'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'BCS_23hr' : begin
        declim=[-53.5,-56.5]
        ralim=[23.2,23.85]*360/24. ;degrees
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file='BCS_23hr'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'BCS_5hr'  : begin
        declim=[-51,-56.5]
        ralim=[ten(5,5),ten(5,50)]*360/24. ;degrees
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file='BCS_5hr'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'SDSS_82'  : begin
        declim=[-1.26,1.26]
        ralim=[0,60]
        marksurveys,nside,declim,ralim,ip1,/astro,/nested
        declim=[-1.26,1.26]
        ralim=[300,360]
        marksurveys,nside,declim,ralim,ip2,/astro,/nested
        ip=[ip1,ip2]
        save,file='SDSS_82'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'COSMOS'   : begin
        dec0=ten(2,12,21)
        ra0=ten(10,0,28.6)*360/24.
        declim=[dec0-1.,dec0+1.]
        ralim=[ra0-1.,ra0+1.]
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file='COSMOS'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'ISWVST'   : begin
        declim=[-54,-56]
        ralim=[ten(23,52,0),24.0]*360./24.
        marksurveys,nside,declim,ralim,ip1,/astro,/nested
       
        declim=[-54,-56]
        ralim=[0.,ten(4,5,0)]*360./24.
        marksurveys,nside,declim,ralim,ip2,/astro,/nested
        
        ip=[ip1,ip2]
        save,file='ISWVST'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'ACTpossible' : begin
        declim=[-81,35]
        ralim=[0,360]
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file='ACTpossible'+trim(nside,2)+'nest',ip,/verbose
    end
    
    'XMMLSS'   : begin
        dec0=ten(-4,30,0)
        ra0= ten(2,20,0)*360./24.
        declim=[dec0-1.5,dec0+1.5]
        ralim=[ra0-1.5,ra0+1.5]
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file='XMMLSS'+trim(nside,2)+'nest',ip,/verbose
    end
    'ACT-SOUTH-SEASON-1':begin
        declim = [-50.,-58.]
        ralim = [30.0,135.5] ;was 113.5
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file = 'ACT-SOUTH-SEASON-1'+trim(nside,2)+'nest' $
          ,ip,/verbose
    end
    'ACT-SOUTH-SEASON-2007a':begin
        declim = [-51.5,-56.]
        ralim = [70.0,140] 
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file = 'ACT-SOUTH-SEASON-2007a'+trim(nside,2)+'nest' $
          ,ip,/verbose
    end
    'ACT-SOUTH-SEASON-2007b':begin
        declim = [-51.5,-56.]
        ralim = [154.0,164.0] 
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file = 'ACT-SOUTH-SEASON-2007b'+trim(nside,2)+'nest' $
          ,ip,/verbose
    end
    'ACT-EQU-SEASON-2007':begin
        declim = [-2.5,2.5]
        ralim = [10.0,170.0] 
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file = 'ACT-EQU-SEASON-2007'+trim(nside,2)+'nest' $
          ,ip,/verbose
    end
    
    'ACT-EQU-2008':begin
        declim = [-1.5,1.5]
        ralim = [110,180]
        marksurveys,nside,declim,ralim,ip,/astro,/nested
        save,file = 'ACT-EQU-2008'+trim(nside,2)+'nest' $
          ,ip,/verbose
    end
    'ACT-SOUTH-2008':begin
        declim = [-56,-49]
        ralim = [0,120]
        marksurveys,nside,declim,ralim,ipACT_SOUTH_2008_1,/astro,/nested
        declim = [-56,-49]
        ralim = [300,360]
        marksurveys,nside,declim,ralim,ipACT_SOUTH_2008_2,/astro,/nested
        ip = [ipACT_SOUTH_2008_1,ipACT_SOUTH_2008_2]
        save,file = 'ACT-SOUTH-2008'+trim(nside,2)+'nest' $
          ,ip,/verbose
    end
endcase

end
