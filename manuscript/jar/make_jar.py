#!/usr/bin/env python3
"""Build the JAR submission source from the preprint source.

The body (Introduction to the rigidity conjecture) comes unchanged from
../conway_involutions.tex.  This script adds the Springer Nature template
(sn-jnl.cls, sn-mathphys-num) front matter and the JAR "Declarations".
Run it after each change to the preprint:  python3 make_jar.py
"""
import re

from pathlib import Path

HERE = Path(__file__).resolve().parent
SRC = HERE.parent / "conway_involutions.tex"
OUT = HERE / "conway_order7_jar.tex"
TAG = "v1.0.0"
COMMIT = "de9a5349552f6ebc3b989e1235f605d2a87b4ab8"

src = SRC.read_text()
abstract = src.split("\\begin{abstract}", 1)[1].split("\\end{abstract}", 1)[0].strip()
body = src.split("\\section{Introduction}", 1)[1].split("\\section*{Declarations}", 1)[0]
body = "\\section{Introduction}" + body.rstrip() + "\n"
assert "\\begin{abstract}" not in body and "\\maketitle" not in body

PREAMBLE = r"""\documentclass[pdflatex,sn-mathphys-num]{sn-jnl}

\usepackage{graphicx}
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{amsthm}
\usepackage{mathtools}
\usepackage{xcolor}
\usepackage{booktabs}
\usepackage{listings}

\lstset{
  basicstyle=\footnotesize\ttfamily,
  breaklines=true,
  breakatwhitespace=true,
  frame=single,
  framerule=0.4pt,
  rulecolor=\color{black!20}
}

\theoremstyle{thmstyleone}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{conjecture}[theorem]{Conjecture}
\theoremstyle{thmstyletwo}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}
\theoremstyle{thmstylethree}
\newtheorem{definition}[theorem]{Definition}

\DeclareMathOperator{\Aut}{Aut}
\DeclareMathOperator{\Fix}{Fix}
\DeclareMathOperator{\Tr}{Tr}
\DeclareMathOperator{\Spec}{Spec}
\DeclareMathOperator{\Stab}{Stab}
\DeclareMathOperator{\Sym}{Sym}

\numberwithin{equation}{section}

\raggedbottom

\begin{document}

\title[A Kernel-Checked Order-7 Exclusion for Conway's 99-Graph]{A Kernel-Checked Lean~4 Proof That Conway's 99-Graph Has No Automorphism of Order~7, with Certified SAT Cross-Checks}

\author*[1]{\fnm{Antonio} \sur{Machuca}}\email{am.machuca.2023@alumnos.urjc.es}

\affil*[1]{\orgdiv{Department of Computer Science and Statistics}, \orgname{Universidad Rey Juan Carlos}, \orgaddress{\city{Madrid}, \country{Spain}}}

"""

FRONT_END = r"""
\keywords{Conway 99-graph, strongly regular graphs, Lean 4, interactive theorem proving, kernel computation, DRAT certification}

\maketitle

"""

BACK = rf"""
\backmatter

\bmhead{{Acknowledgements}}
The author thanks the developers of CaDiCaL, \texttt{{drat-trim}}, PySAT, and Lean~4 for their open-source tools.

\section*{{Declarations}}

\begin{{itemize}}
\item \textbf{{Funding.}} No funding was received for this work.
\item \textbf{{Competing interests.}} The author has no competing financial or non-financial interests.
\item \textbf{{Ethics approval and consent to participate.}} Not applicable.
\item \textbf{{Consent for publication.}} Not applicable.
\item \textbf{{Data availability.}} The Zenodo record \url{{https://doi.org/10.5281/zenodo.22995101}} contains the canonical order-7 CNF, its DRAT proof, the CaDiCaL 1.9.5 log, and the \texttt{{drat-trim}} log. The exterior-row CNF and its proof are not in that record. The files \texttt{{tests/production\_positive\_control\_results.json}} and \texttt{{tests/z7\_general\_run\_result.json}} in the code repository record the positive-control output and the bounded quotient-level run, with SHA-256 digests.
\item \textbf{{Materials availability.}} Not applicable.
\item \textbf{{Code availability.}} The Lean~4 library, the SAT encoders, the regression tests, and the scripts are at \url{{https://github.com/antoniomachuca/conway-99-graph}}, tag \texttt{{{TAG.replace('_', r'\_')}}}. The order-7 proof is at commit \texttt{{{COMMIT}}}.
\item \textbf{{Author contribution.}} Antonio Machuca is the only author. He wrote the Lean library, the SAT encoders, the tests, and the manuscript, and he is responsible for all content.
\item \textbf{{Use of large language models.}} The author used large language models for code maintenance, test generation, proof work, and LaTeX edits. The Lean kernel, the regression tests, and the retained solver and checker logs check only the statements and files that the text names. The output of a model is not an independent mathematical review.
\end{{itemize}}

\bibliography{{references}}

\end{{document}}
"""

OUT.write_text(PREAMBLE + "\\abstract{" + abstract + "}\n" + FRONT_END + body + BACK)
# sn-mathphys-num.bst breaks URLs that contain "~" (as \texttildelow it loops, as %7E it starts a
# comment inside \burl).  Move such URLs out of the url field into a \url in howpublished/note.
bib = (HERE.parent / "references.bib").read_text()


def move_tilde_url(entry):
    m = re.search(r"\n\s*url\s*=\s*\{([^}]*~[^}]*)\},?", entry)
    if not m:
        return entry
    entry = entry.replace(m.group(0), "")
    link = "\\url{" + m.group(1) + "}"
    n = re.search(r"(\n\s*note\s*=\s*\{)([^}]*)\}", entry)
    if n:
        return entry.replace(n.group(0), n.group(1) + n.group(2) + ". " + link + "}")
    body, close = entry.rstrip().rsplit("}", 1)
    return body.rstrip().rstrip(",") + ",\n  note = {" + link + "}\n}" + close


bib = "".join(move_tilde_url(e) for e in re.split(r"(?=\n@)", bib))
assert "url" not in "".join(l for l in bib.splitlines() if "~" in l and "\\url" not in l)
(HERE / "references.bib").write_text(bib)
print(f"wrote {OUT.name} ({len(OUT.read_text().splitlines())} lines) and references.bib")
