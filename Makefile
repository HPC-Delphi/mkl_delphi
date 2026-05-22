CC        = icx-cc
CFLAGS    = -Wall -O3
MKL_COPTS = -DMKL_ILP64 -qmkl -I$(INCLUDE_COMMON)

SRC_DIR   = src
OBJ_DIR   = build
INC_DIR   = include

SRC       = $(SRC_DIR)\mkl_delphi.c
INC       = $(INC_DIR)\mkl_delphi.h
OBJ       = $(OBJ_DIR)\mkl_delphi.o
EXP       = $(OBJ_DIR)\mkl_delphi.exp
IMPLIB    = $(OBJ_DIR)\mkl_delphi.lib
TARGET    = $(OBJ_DIR)\mkl_delphi.dll

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -shared -o $(TARGET) $(OBJ) $(MKL_COPTS)
	del /q $(OBJ)
	if exist $(EXP) del /q $(EXP)
	if exist $(IMPLIB) del /q $(IMPLIB)

$(OBJ): $(SRC) $(INC)
	if not exist $(OBJ_DIR) mkdir $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $(SRC) -o $(OBJ)

clean:
	if exist $(OBJ_DIR) rmdir /s /q $(OBJ_DIR)