#include "game.h"


/**
	Inits gameboard in @g
*/
void init_gameboard(game* g) {
	int i = 0;

	int temp[64] = {
		//-1 represents "WHITE" field (not possible), 0 available field ("BLACK")
                // 1 "player" stone, 3 "player" king, 2 "enemy" stone, 4 "enemy king

              // 0    1    2    3    4    5    6    7
                -1 ,  2 , -1 ,  2 , -1 ,  2 , -1 ,  2, //0
                 2 , -1 ,  2 , -1 ,  2 , -1 ,  2 , -1, //1
                -1 ,  2 , -1 ,  2 , -1 ,  2 , -1 ,  2, //2
                 0 , -1 ,  0 , -1 ,  0 , -1 ,  0 , -1, //3
                -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 ,  0, //4
                 1 , -1 ,  1 , -1 ,  1 , -1 ,  1 , -1, //5
                -1 ,  1 , -1 ,  1 , -1 ,  1 , -1 ,  1, //6
                 1 , -1 ,  1 , -1 ,  1 , -1 ,  1 , -1, //7


		/*
		-1 ,  2 , -1 ,  3 , -1 ,  2 , -1 ,  2, //0
                2 , -1 ,  0 , -1 ,  2 , -1 ,  2 , -1, //1
                -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 ,  2, //2
                0 , -1 ,  0 , -1 ,  0 , -1 ,  2 , -1, //3
                -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 ,  0, //4
                1 , -1 ,  1 , -1 ,  1 , -1 ,  1 , -1, //5
                -1 ,  1 , -1 ,  1 , -1 ,  1 , -1 ,  1, //6
                1 , -1 ,  1 , -1 ,  1 , -1 ,  1 , -1, //7
		*/
	};

	for(i = 0; i < 64; i++) {
		g->gameboard[i] = temp[i];
	}
}

/**
	Allocs memory for game and initializes default values
*/
game* init_new_game() {
	game* new = calloc(1, sizeof(game));

	if(!new) return NULL;

	init_gameboard(new);
	bzero(new->gamename, 64);
	new->p1 = NULL;
	new->p2 = NULL;
	new->on_turn = NULL;

	return new;
}

/**
	Adds player to game. Returns 1 if game is already full. 0 on succes
*/
int add_player_to_game(game* g, player* p) {
	if(g->p1) {
		if(g->p2) {
			return 1;
		} else {
			g->p2 = p;
		}
	} else {
		g->p1 = p;
	}
	
	return 0;
}


/**
	Finds game with matching player pointer (@p).
	Returns NULL if it fails to find game
*/
game* find_game_by_player(l_link* head, player* p) {
        while(head) {
                if(((game*) head->data)->p1 == p ||
                   ((game*) head->data)->p2 == p) {
                        return (game*) head->data;
                }

		head = head->next;
        }

        return NULL;
}


/**
	Finds game with name @lobby_name. Returns pointer on it and 
	removes it from @head list
*/
game* extract_game_by_name(l_link** head, char* lobby_name) { 
	game* out = NULL;
	l_link *prev = NULL, *curr = NULL;

	curr = *head;

	if(!curr) return NULL;

	while(curr) {
		if(!strcmp(((game*) curr->data)->gamename, lobby_name)) {
                        out = (game*) curr->data;
			break;
		}

		prev = curr;
		curr = curr->next;
        }

	if(prev) {
		prev->next = curr->next;
	} else {
		*head = curr->next;
	}

	free(curr);

        return out;
}


int get_dir_from_points(int from, int to) {
	int vector = to - from;

	if(vector < 0) {
		if(!(vector % 7)) return -7;
		if(!(vector % 9)) return -9;
	} else {
		if(!(vector % 7)) return 7;
		if(!(vector % 9)) return 9;
	}

	return 0;
}

int validate_direction_step(int from, int dir, game* g, int on_top) {
	int target = from + dir;

	if(target < 0 || target > 63) { //target is out of board
            return -1;
        } else if(g->gameboard[target] == 0) { //target is empty field
            return target;
        } else {
		if(on_top) {
			if(g->gameboard[target] == 1 || g->gameboard[target] == 3) { //target is occupied by opponent stone
           			target += dir;

           			if(target < 0 || target > 63) return -1;
           			if(g->gameboard[target] == 0) return target;
			}
		} else {
			if(g->gameboard[target] == 2 || g->gameboard[target] == 4) { //target is occupied by opponent stone
           			target += dir;

           			if(target < 0 || target > 63) return -1;
           			if(g->gameboard[target] == 0) return target;
			}

		}
        }

        return -1;	
}


int validate_move_direction(game* g, int on_top, int from, int to, int subseq) {
	int vector = to - from;

	//target location must be 0
	if(g->gameboard[to] != 0)  {
		return 1;
	}

	//source location must be 2/ 4 for player on top 1/ 3 for player on bot
	if(subseq == 1) {
		if(on_top) {
			if((g->gameboard[from] % 2) != 0) {
				return 1;
			}
		} else {
			if((g->gameboard[from] % 2) != 1) {
				return 1;
			}
		}
	}

	//if jumping over opponent stone, verify opponent stone is in between
	if(vector == 2 * 7 || vector == 2 * -7 || vector == 2 * 9 || vector == 2 * -9) {
		if(on_top) {
			if((g->gameboard[from + (vector / 2)] % 2) != 1) {
				return 1;
			}
		} else {
			if((g->gameboard[from + (vector / 2)] % 2) != 0) {
				return 1;
			}
		}
	}

	return 0;
}


int validate_move(int from, int to, player*p , game* g, int subsequent) {
	//check for index out of bounds (gameboard has 64 fields)
	if(to > 63 || to < 0 || from > 63 || from < 0) {
		return 1;
	}

	//if player is on top, reverse indexes (player moves in opposite direction)
	if(p->on_top) {
		from = 63 - from;
		to = 63 - to;
	}

	// stone is a king
	if(g->gameboard[from] == 4 || g->gameboard[from] == 3) {
		if(validate_move_direction(g, p->on_top, from, to, subsequent)) {
			return 1;
		}

	} else { //stone isn't a king
		//normal stones on top only move downward (index in gameboard increases)
		if(subsequent == 1) {
			if(p->on_top) {
				if(to < from) return 1;
			} else { // stones on bot only move upward (index in gb decreases)
				if(to > from) return 1;
			}
		}

		if(validate_move_direction(g, p->on_top, from, to, subsequent)) {
			return 1;
		}
	}

	return 0;
}


/**
	Prints game @g in 8x8 (for debugging)
*/
void print_gameboard(game* g) {
	int i = 0;

	for(i = 0; i < 64; i++) {
		printf("%d  ", g->gameboard[i]);
		if((i % 8) == 7) printf("\n");
	}
}

/**
	Makes move in gameboard of game @g, @from to @to
*/
void make_move(int from, int to, player* p, game* g) {
	if(p->on_top) {
		if((63 - to) >= 56) {
			g->gameboard[63 - to] = 4;
		} else {
			g->gameboard[63 - to] = g->gameboard[63 - from];
		}


		if((to - from) > 9 || (to - from) < -9) {
			g->gameboard[63 - (from + (to - from) / 2)] = 0;
		}

		g->gameboard[63 - from] = 0;
	} else {
		if(to < 8) {
			g->gameboard[to] = 3;
		} else {
			g->gameboard[to] = g->gameboard[from];
		}

		if((to - from) > 9 || (to - from) < -9) {
			g->gameboard[from + (to - from) / 2] = 0;
		}

		g->gameboard[from] = 0;
	}
}


player* check_for_victory(game* g) {
	int p1_cnt = 0, p2_cnt = 0, i = 0;

	for(i = 0; i < 64; i++) {
		if(g->gameboard[i] > 0) {
			//p2 is always on top, so p2 always has 2/4
			if(g->gameboard[i] % 2 == 0) {
				p2_cnt++;
			} else {
				p1_cnt++;
			}
		}
	}

	if(!p2_cnt) {
		return g->p2;
	}

	if(!p1_cnt) {
		return g->p1;
	}
	
	return NULL;
}


player* get_your_opponent(game* g, player* p) {
	if(g) {
		//if on_turn != NULL ->  game in progress (== NULL -> waiting for player)
		if(g->on_turn) {
			if(g->p1 == p) return g->p2;
			else if(g->p2 == p) return g->p1;
		}
	}

	return NULL;
}


/**
	Deletes game @g from list @head and frees allocated memory of both @g and 
	l_link storing @g
*/
int delete_game_from_list(l_link **head, game* g) {
        l_link *prev = NULL, *curr = NULL;
                                 
        curr = (*head);
              
        while(curr) {
                if((game*) curr->data == g) {
                        break;
                }
                         
                prev = curr;
                curr = curr->next;
        }               
                        
        if(!curr) {     
                return 1;
        }               
                
        free_game((game*) curr->data);
        //free(curr->data);
                
        if(prev) {
                prev->next = curr->next;
        } else {
                //if prev = NULL, its the beginning of the lobby
                // -> need to change 
                (*head) = (*head)->next;
        }       
        
        free(curr);        
        
        return 0;          
}


/**
	Makes gameboard string to be sent with reconnect
*/
char* gameboard_to_string(game* g) {
	int i = 0, count = 0;
	char* str = calloc(33, sizeof(char));

	if(!str) return NULL;

	for(i = 0; i < 64; i++) {
		if(g->gameboard[i] >= 0) {
			sprintf(str + count * sizeof(char), "%d", g->gameboard[i]);
			count++;
		}
	}

	return str;
}


/**
	Free game memory
*/
void free_game(game* g) {
	free(g);
}
