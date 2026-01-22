# Forestplot for 18 Subgroups

# --- Install packages once (if not already installed) ---
if(!requireNamespace("ragg",   quietly=TRUE)) install.packages("ragg")
if(!requireNamespace("forestplot", quietly=TRUE)) install.packages("forestplot")
if(!requireNamespace("tibble", quietly=TRUE)) install.packages("tibble")
if(!requireNamespace("magick", quietly=TRUE)) install.packages("magick")

# --- Load libraries ---
library(ragg)
library(forestplot)
library(tibble)
library(magick)

# --- Your data ---
# mean: Hazard Ratio
# lower: lower 95% confidence interval
# upper: upper 95% confidence interval

base_data <- tibble::tibble(
  mean  = c(0.54,0.51,0.48,0.58,0.52,0.50,0.45,0.52,0.52,0.57,0.67,0.41,0.55,0.49,0.62,0.49,0.60,0.31),
  lower = c(0.33,0.34,0.29,0.38,0.29,0.34,0.16,0.37,0.36,0.31,0.44,0.26,0.38,0.27,0.38,0.32,0.43,0.11),
  upper = c(0.88,0.77,0.78,0.89,0.93,0.74,1.24,0.73,0.76,1.04,1.02,0.67,0.80,0.90,1.00,0.75,0.84,0.88)
)

# --- empty labels (same number of rows as data) ---
empty_labels <- matrix("", nrow = nrow(base_data), ncol = 1)

# --- Output parameters ---
dpi <- 600
width_in  <- 2.80   # Breite in Zoll (anpassen wenn du breiter willst)
height_in <- 3.70    # Höhe in Zoll (gleich lassen falls gewünscht)
outfile <- "forestplot_nur_daten_600dpi.png"

# --- Open device (ragg, reliable) ---
ragg::agg_png(filename = outfile,
              width  = round(width_in * dpi),
              height = round(height_in * dpi),
              units  = "px",
              res    = dpi)

# --- Draw the plot (forestplot draws directly, no pipes) ---
# Clip controls the x-axis range
forestplot(
  labeltext = empty_labels,        # no text on the left
  mean  = base_data$mean,
  lower = base_data$lower,
  upper = base_data$upper,
  zero  = 1,
  clip  = c(0.1, 2.0),
  xlog  = TRUE,
  boxsize = 0.18,
  col = fpColors(box = "darkblue", line = "black", zero = "gray50"),
  xlab = ""                         # no x-axis label
)

# --- Close the device (very important) ---
dev.off()

# --- Check ouptut info and open the file in viewer ---
info <- image_info(image_read(outfile))
print(info[, c("width", "height", "density")])
message("File written: ", normalizePath(outfile))
browseURL(normalizePath(outfile))   # opens the file automatically (in RStudio/OS)
