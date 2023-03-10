##
## EPITECH PROJECT, 2022
## B-FUN-400-MAR-4-1-wolfram-thibaut.tran
## File description:
## Makefile
##

NAME = wolfram

all :
	@stack build
	@cp $(shell stack path --local-install-root)/bin/$(NAME)-exe ./$(NAME)

clean :
	stack clean

fclean : clean
	@rm -f	$(NAME)

re :	fclean all

.PHONY : all clean fclean re