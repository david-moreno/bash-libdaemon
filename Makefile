NAME=libdaemon
DIR=/usr/lib/bash
#MANDIR=/usr/share/man/man

install:
	mkdir -p $(DIR)
	install -m 644 $(NAME) $(DIR)
	#install $(MAN_NAME) $(MANDIR)

uninstall:
	rm -f $(DIR)/$(NAME)
	#rm -f $(DIR)/$(NAME)
