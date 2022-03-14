library(tidyverse)
devtools::session_info(c("tidyverse"))
library( "gapminder")
library(nycflights13)
library(Lahman)
library(bookdown)
library(ggplot2)
# http://bit.ly/r-for-data-science pagina para errata do livro
# install.packages(c("nycflights13", "gapminder", "Lahman"))
# tidyverse_update() atualizar 
# If we want to make it clear what package an object comes from,
# we'll use the package name followed by two colons, like
# dplyr::mutate() or nycflights13::flights. This is also valid R code.

# (If the error message isn't in English,
# run Sys.setenv(LANGUAGE = "en")

# Visualização de dados com ggplot2

ggplot2::mpg
mpg
# criando um gráfico com ggplot2
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#obtendo algumas informações básicas sobre os dados
class(mpg)
View(mpg)# para visualizar os dados
length(mpg)# 11 colunas
length(mpg$model) # 234 linhas
summary(mpg$drv)
mpg$drv

#gráfico
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))


ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))# esse gráfico não tras nenhuma informação

# adicionando cores a cada tipo de carro=class
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

## mapeando por size de class
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
# Top
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class)) #transparencia dos pontos classes
# Bottom
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) # forma dos pontos por classes

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) +
  geom_point( mapping = aes(x = displ, y = hwy, color = displ < 5))

# facets - útil para variáveis categóricas
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# geometric objects (meche com a estética do gráfico)
# left
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) # a geometria aqui é por pontos

# right
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))


ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))# sem legenda

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE)# colorido e sem legenda

# to display multiple geoms in the same plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# other way
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )


# Statistical Transformations
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))# esse vem por default

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

# especifica quantas barras você quer
demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40 )
ggplot(data = demo) +
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity"
  )

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, y = ..prop.., group = 1)
  )# aqui mostra as proporções das barras ao inves de contagem


ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )#gráfico que mostra mínimo, máximo e mediana



# Position Adjustments - colorindo o gráfico - 
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))# Cada retângulo colorido representa uma combinação de cut e clarity 

# outras formas de preencimento das barras
  # position = "identity"
ggplot(
  data = diamonds,
  mapping = aes(x = cut, fill = clarity)
) +
  geom_bar(alpha = 1/5, position = "identity")

ggplot(
  data = diamonds,
  mapping = aes(x = cut, color = clarity)
) +
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "fill"
  )

# position = "dodge"
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "dodge"
  )

# position "jitter" - odiciona rído aleatório aos pontos
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )

# Coordinate Systems
  # coord_flip()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()# boxplot na vertical
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()# boxplot na horizontal 
 
# coord_quickmap()

nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

# coord_polar()
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()
