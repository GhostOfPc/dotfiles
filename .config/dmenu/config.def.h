/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 960;                    /* minimum width when centered */
static int colorprompt = 1;                /* -p  option; if 1, prompt uses SchemeSel, otherwise SchemeNorm */
static int fuzzy = 0;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"FantasqueSansMono Nerd Font:size=10",
    "JoyPixels:size=10:antialias=true:hinting=true"
};
static const unsigned int bgalpha = 0xc8;
static const unsigned int fgalpha = OPAQUE;
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#121212"},
	[SchemeSel] = { "#fef26c", "#545454" },
	[SchemeSelHighlight] = { "#af87ff", "#0f7fcf" },
	[SchemeNormHighlight] = { "#f5669c", "#121212" },
	[SchemeOut] = { "#121212", "#97e123" },
	[SchemeHp] = { "#f5669c", "#545454" }
};
static const unsigned int alphas[SchemeLast][2] = {
	/*		fgalpha		bgalphga	*/
	[SchemeNorm] = { fgalpha, bgalpha },
	[SchemeSel] = { fgalpha, bgalpha },
	[SchemeSelHighlight] = { fgalpha, bgalpha },
	[SchemeNormHighlight] = { fgalpha, bgalpha },
	[SchemeOut] = { fgalpha, bgalpha },
	[SchemeHp] = { fgalpha, bgalpha }
};

/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int columns    = 0;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 40;
static unsigned int min_lineheight = 40;
static unsigned int xoffset = 5;
static unsigned int yoffset = 3;
static unsigned int max_width = 3830;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;
