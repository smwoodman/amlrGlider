% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/amlr_ngdac_convert.R
\name{amlr_ngdac_convert}
\alias{amlr_ngdac_convert}
\title{Convert AMLR L1 and L2 glider data to NGDAC format v2.0}
\usage{
amlr_ngdac_convert(
  file.l1,
  file.l2,
  file.out.path,
  glider.name,
  wmo.id,
  ctd.info,
  flbbcd.info,
  oxygen.info,
  ctd.comment = "pumped CTD",
  flbbcd.comment = " ",
  oxygen.comment = " "
)
}
\arguments{
\item{file.l1}{file path for AMLR L1 nc file}

\item{file.l2}{file path for AMLR L2 nc file}

\item{file.out.path}{file path to folder where output nc files will be created}

\item{glider.name}{character; name of glider}

\item{wmo.id}{character; the WMO ID of the glider/deployment.
If there is no WMO ID, this should be a single space, i.e. \code{" "}}

\item{ctd.info}{list; CTD information. Must contain the following named elements:
calib_date (Date), calib_date_factory (Date), and serial_num (character)}

\item{flbbcd.info}{list; flbbcd information. Must contain the following named elements:
calib_date (Date), calib_date_factory (Date), and serial_num (character)}

\item{oxygen.info}{list; oxygen oxygen information. Must contain the following named elements:
calib_date (Date), calib_date_factory (Date), and serial_num (character)}

\item{ctd.comment}{character; string to pass to 'comment' attribute of 'instrument_ctd' variable.
Default is \code{"pumped CTD"}}

\item{flbbcd.comment}{character; string to pass to 'comment' attribute of 'instrument_flbbcd' variable.
Default is \code{" "}}

\item{oxygen.comment}{character; string to pass to 'comment' attribute of 'instrument_oxygen' variable.
Default is \code{" "}}
}
\value{
\code{TRUE} if the function ran successfully.
This functions writes one nc file per profile to the folder specified by \code{file.out.path}
}
\description{
Convert AMLR L1 and L2 glider data to NGDAC format v2.0
}
\details{
Raw AMLR glider data is initially processed using the
SOCIB glider toolbox (\url{https://github.com/socib/glider_toolbox}).
Thus, processed AMLR glider data consists of an L1 and L2 file containing
time series (trajectory) and profile data, respectively.
This function takes these L1 and L2 output files and converts them to NGDAC format v2.0.
This process consists of creating individual nc files for each profile,
and extracting both time series and profile-level information for each new nc file.
See the NGDAC wiki \url{https://ioos.github.io/ioosngdac/ngdac-netcdf-file-format-version-2.html}
for more details.

In addition to the variables time series variables listed at the NGDAC website,
this function writes several other variables to the output nc files.
These data are collected using flbbcd and oxygen instruments; the metadata for
these instruments is included in instrument_flbbcd and instrument_oxygen, respectively.
The variables, along with their standard names (from
\url{http://cfconventions.org/Data/cf-standard-names/73/build/cf-standard-name-table.html})
are as follows:

\tabular{l}{
cdom: concentration_of_colored_dissolved_organic_matter_in_sea_water_expressed_as_equivalent_mass_fraction_of_quinine_sulfate_dihydrate\cr
chlorophyll: concentration_of_chlorophyll_in_sea_water\cr
backscatter: volume_backwards_scattering_coefficient_of_radiative_flux_in_sea_water (from backscatter_700 variable)\cr
radiation_wavelength: radiation_wavelength (700 for all values)\cr
oxygen_saturation: fractional_saturation_of_oxygen_in_sea_water\cr
oxygen_concentration: mole_concentration_of_dissolved_molecular_oxygen_in_sea_water
}

When adding data and attributes to the new nc file(s),
data is extracted from the L1 and L2 files where applicable (e.g. most variable standard names),
but most of the codes/names/info are hard-coded in the function and thus the function will
need to be changed if 1) the L1/L2 file structure changes or 2) the NGDAC requirements change.
Dynamic (aka deployment-specific) information is either calculated from the data
(e.g. deployment date/time) or passed to function via arguments (e.g. CTD calibration information)
}
\examples{
\dontrun{
amlr_ngdac_convert( #This is not full deployment data
  file.l1 = "AERD_18_19/dep100_amlr01_sgg3_L1_2018-12-06_data_rt.nc",
  file.l2 = "AERD_18_19/dep100_amlr01_sgg3_L2_2018-12-06_data_rt.nc",
  file.out.path = "Output/dep100_amlr01_sgg3/",
  glider.name = "amlr01", wmo.id = "0",
  ctd.info = list(
    calib_date = as.Date("2000-01-01"), calib_date_factory = as.Date("2000-01-01"),
    serial_num = "1"
  ),
  flbbcd.info = list(
    calib_date = as.Date("2000-01-01"), calib_date_factory = as.Date("2000-01-01"),
    serial_num = "3"
  ),
  optode.info = list(
    calib_date = as.Date("2000-01-01"), calib_date_factory = as.Date("2000-01-01"),
    serial_num = "2"
  )
)
}

}
