######Kruskal
```{r}
kruskal.test(agegapreg_multi ~ at_pos_gmm,  data = multiage_atn)
```
######Pairwise
```{r}
compare_means(agegapreg_multi ~ at_pos_gmm,  data = multiage_atn, method = "wilcox")
my_comparisons <- list( #c("A-T-", "A+T-"), c("A+T-", "A+T+"), c("A-T-", "A+T+"),
  # c("A-T-", "A+T-")
  #, c("A+T-", "A+T+"), 
  c("A-T-", "A+T+")
  , c("A+T+", "CDR > 0"), c("A+T-", "CDR > 0"), c("A-T-", "CDR > 0")
  
  #c("A+T-", "A+T+"), 
  #c("A-T-", "Symptomatic AD"), c("A+T-", "Symptomatic AD"), c("Symptomatic AD", "A+T+")
  
)

```
######Violin Plot

```{r}
p<-ggplot(multiage_atn, aes(x=at_pos_gmm, y=agegapreg_multi, fill=at_pos_gmm)) +
  labs(title="Vol+FC-BAG",x="", y = "Residual Vol+FC-BAG") +
  geom_violin(trim=FALSE, color = "black") + 
  scale_fill_manual(breaks=c("A-T-", "A+T-", "A+T+", "CDR > 0"),
                    values=c("blue", "forestgreen", "orange", "red")) +
  
  geom_hline(yintercept = 0, linetype = "longdash") +
  geom_boxplot(width=0.3, color = "black") +
  #geom_jitter(shape=16, position=position_jitter(0.05)) +
  stat_compare_means(comparisons = my_comparisons, method = "wilcox"
                     , aes(label = ..p..)
  )+ # Add pairwise comparisons p-value
  #stat_compare_means(label.y = 50)+     # Add global p-value
  ylim(min(-30), max(40)) + 
  theme_classic(base_size = 15) +
  theme(legend.position="none", plot.title = element_text(hjust = 0.5))
p
ggsave('multiage_abtausym_violin_harm_220516.png', width = 5, height = 5, units = "in", dpi = 320)
```