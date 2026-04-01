# run_report.R


## Set station of interest
stations <- c(5,21)

for(i in length(stations)){
  station <- stations[i]
  station_s <- paste0("S", sprintf("%02d",station))
  
  # Set data path
  data_path <- '/Users/f.garzon/Library/CloudStorage/OneDrive-UniversityofExeter/Projects/S3 Project - Documents/Data/'
  
  ## Get station metadata
  meta <- readxl::read_xlsx(paste0(data_path,"MetaData.xlsx"))
  
  # Load spatial data
  # Land polygon (coastline)
  land_sf <- read_sf('/Users/f.garzon/Library/CloudStorage/OneDrive-UniversityofExeter/Projects/S3 Project - Documents/GIS/Land/gadm36_0.shp')
  
  #PDAs polygon
  pda_sf <- read_sf('/Users/f.garzon/Library/CloudStorage/OneDrive-UniversityofExeter/Projects/S3 Project - Documents/GIS/PDAs/PDAs.shp')
  
  # Stations point data (8 stations in a grid)
  stations_sf <- read_sf("/Users/f.garzon/Library/CloudStorage/OneDrive-UniversityofExeter/Projects/S3 Project - Documents/GIS/s3_locations_new_wgs84.shp")
  names(stations_sf)[1]<-"Station"
  
  rmarkdown::render(
    "/Users/f.garzon/Library/CloudStorage/OneDrive-UniversityofExeter/Projects/S3 Project - Documents/Analysis/SoundTrap_Report_pdf.Rmd",
    output_file = paste0("/Users/f.garzon/Library/CloudStorage/OneDrive-UniversityofExeter/Projects/S3 Project - Documents/Documents/DataReports/", station_s, "_R1_DataReport.pdf")
  )
}
