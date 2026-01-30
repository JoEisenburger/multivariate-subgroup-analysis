# Forestplot for 18 Subgroups

# --- Install packages once (if not already installed) ---
if (!requireNamespace("forestplot", quietly = TRUE)) install.packages("forestplot")
if (!requireNamespace("tibble", quietly = TRUE))     install.packages("tibble")

# --- Load Libraries ---
library(forestplot)
library(tibble)

# --- Your data ---
# mean: Hazard Ratio
# lower: lower 95% confidence interval
# upper: upper 95% confidence interval

base_data <- tibble(
  mean  = c(0.36, 0.35, 0.78, 0.16, 0.25, 0.36, 0.00, 0.37, 0.41, 0.22, 0.32, 0.41, 0.39, 0.16, 0.41, 0.29, 0.31, 0.69),
  lower = c(0.17, 0.19, 0.40, 0.07, 0.10, 0.21, 0.00, 0.24, 0.24, 0.09, 0.19, 0.17, 0.24, 0.04, 0.19, 0.16, 0.18, 0.26),
  upper = c(0.73, 0.64, 1.54, 0.36, 0.59, 0.61, 0.00, 0.59, 0.71, 0.52, 0.54, 0.98, 0.64, 0.56, 0.87, 0.52, 0.51, 1.78)
)

# --- empty labels (same number of rows as data) ---
empty_labels <- matrix("", nrow = nrow(base_data), ncol = 1)

# --- Output parameters ---
width_in  <- 2.8
height_in <- 3.7
outfile   <- "forestplot_only_points_vector.pdf"

# PDF-Device (Vektor)
pdf(
  file = outfile,
  width  = width_in,
  height = height_in,
  bg = "transparent",
  useDingbats = FALSE
)

# --- Draw the plot 
# Clip controls the x-axis range
forestplot(
  labeltext = empty_labels,
  mean  = base_data$mean,
  lower = base_data$lower,
  upper = base_data$upper,
  zero  = 1,
  clip  = c(0.03, 2.0),
  xlog  = TRUE,
  
  boxsize = 0.18,
  
  col = fpColors(
    box  = "darkblue",
    line = "black",
    zero = "gray60"
  ),
  
  xlab = "",
  graph.pos = 1,
  new_page = TRUE
)

# Close Devise

dev.off()

message("Saved as: ", normalizePath(outfile))
browseURL(normalizePath(outfile))
