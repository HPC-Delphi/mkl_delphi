unit MKL;

interface

uses
  System.SysUtils;

const
  DLLNAME = 'mkl_delphi.dll';

  {
    * Enumerated and derived types
    *
    * Delphi enums with $Z4 are binary compatible with C enums (4-byte int),
    * so they can be used directly in external C DLL calls as long as their range fits Integer,
    * which is the case.
  }
  {$Z4}
type
  MKL_INT = Integer;

  CBLAS_LAYOUT = (CblasRowMajor = 101, CblasColMajor = 102);
  CBLAS_TRANSPOSE = (CblasNoTrans = 111, CblasTrans = 112,
    CblasConjTrans = 113);

procedure cblas_dgemm(const Layout: CBLAS_LAYOUT;
  const TransA, TransB: CBLAS_TRANSPOSE; const M, N, K: MKL_INT;
  const alpha: Double; const A: PDouble; const lda: MKL_INT; const B: PDouble;
  const ldb: MKL_INT; const beta: Double; C: PDouble; const ldc: MKL_INT);
  cdecl; external DLLNAME name '_cblas_dgemm';

implementation

end.