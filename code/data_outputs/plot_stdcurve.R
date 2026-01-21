plot_stdcurve <- function(std_data){
std_data %>%
  ggplot(aes(mean_conc, mean_od, colour = factor(week))) +
  geom_point() +
  theme_classic() +
  labs(title = "Standard curve",
       x = "Predicted Concentration",
       y = "Mean OD")
}