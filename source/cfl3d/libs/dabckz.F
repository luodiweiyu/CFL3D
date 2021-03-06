c  ---------------------------------------------------------------------------
c  CFL3D is a structured-grid, cell-centered, upwind-biased, Reynolds-averaged
c  Navier-Stokes (RANS) code. It can be run in parallel on multiple grid zones
c  with point-matched, patched, overset, or embedded connectivities. Both
c  multigrid and mesh sequencing are available in time-accurate or
c  steady-state modes.
c
c  Copyright 2001 United States Government as represented by the Administrator
c  of the National Aeronautics and Space Administration. All Rights Reserved.
c 
c  The CFL3D platform is licensed under the Apache License, Version 2.0 
c  (the "License"); you may not use this file except in compliance with the 
c  License. You may obtain a copy of the License at 
c  http://www.apache.org/licenses/LICENSE-2.0. 
c 
c  Unless required by applicable law or agreed to in writing, software 
c  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
c  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the 
c  License for the specific language governing permissions and limitations 
c  under the License.
c  ---------------------------------------------------------------------------
c
      subroutine dabckz(i,npl,jdim,kdim,idim,a,b,c,blank)
c***********************************************************************
c     Purpose:  Use the blank values to modify the coefficient matrices,
c     a,b,c , for the diagonal inversion in the K-direction.
c***********************************************************************
c
#   ifdef CMPLX
      implicit complex(a-h,o-z)
#   endif
c
      dimension a(jdim-1,npl,kdim),b(jdim-1,npl,kdim), 
     .          c(jdim-1,npl,kdim),blank(jdim,kdim,idim)
c
      jdim1 = jdim-1 
c
      do 10 k=1,kdim 
      do 10 ipl=1,npl
      ii = i+ipl-1 
cdir$ ivdep
      do 11 j=1,jdim1
      a(j,ipl,k) = a(j,ipl,k)*blank(j,k,ii)
      c(j,ipl,k) = c(j,ipl,k)*blank(j,k,ii)
      b(j,ipl,k) = (b(j,ipl,k)*blank(j,k,ii))+(1.0-blank(j,k,ii))
   11 continue
   10 continue
      return 
      end
