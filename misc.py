class Colors:
    DONE = "\033[32m"
    NOTDONE = "\033[31m"
    HIGHLIGHT = "\033[33m"
    NORMAL = "\033[0m"

    def color(self, txt: str, mode: None | bool = None):
        if mode is None:
            return f"{self.HIGHLIGHT}{txt}{self.NORMAL}"
        if not mode:
            return f"{self.NOTDONE}{txt}{self.NORMAL}"
        return f"{self.DONE}{txt}{self.NORMAL}"
