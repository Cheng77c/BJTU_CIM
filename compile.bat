@echo off
echo Starting complete LaTeX compilation...

echo.
echo Step 1: First XeLaTeX compilation...
xelatex -interaction=nonstopmode bjtu_template.tex
rem Check if PDF was generated successfully
if not exist bjtu_template.pdf (
    echo Error in first XeLaTeX compilation - PDF not generated
    pause
    exit /b 1
)

echo.
echo Step 2: BibTeX compilation for bibliography...
bibtex bjtu_template
if %errorlevel% neq 0 (
    echo Error in BibTeX compilation
    pause
    exit /b 1
)

echo.
echo Step 3: Second XeLaTeX compilation for cross-references...
xelatex -interaction=nonstopmode bjtu_template.tex
rem Check if PDF still exists after second compilation
if not exist bjtu_template.pdf (
    echo Error in second XeLaTeX compilation - PDF not found
    pause
    exit /b 1
)

echo.
echo Step 4: Final XeLaTeX compilation for table of contents...
xelatex -interaction=nonstopmode bjtu_template.tex
rem Check if PDF still exists after final compilation
if not exist bjtu_template.pdf (
    echo Error in final XeLaTeX compilation - PDF not found
    pause
    exit /b 1
)

echo.
echo Compilation completed successfully!
echo Generated files:
if exist bjtu_template.pdf (
    echo - bjtu_template.pdf ^(final document^)
)
if exist bjtu_template.aux (
    echo - bjtu_template.aux ^(auxiliary file^)
)
if exist bjtu_template.toc (
    echo - bjtu_template.toc ^(table of contents^)
)
if exist bjtu_template.bbl (
    echo - bjtu_template.bbl ^(bibliography^)
)

echo.
echo Opening PDF file...
if exist bjtu_template.pdf (
    start bjtu_template.pdf
) else (
    echo PDF file not found!
)

pause