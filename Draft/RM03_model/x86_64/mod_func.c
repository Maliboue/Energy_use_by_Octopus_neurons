#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _hcno_reg(void);
extern void _ih_reg(void);
extern void _ka_reg(void);
extern void _kht_reg(void);
extern void _klt_reg(void);
extern void _leak_reg(void);
extern void _mujpow_reg(void);
extern void _na_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," hcno.mod");
    fprintf(stderr," ih.mod");
    fprintf(stderr," ka.mod");
    fprintf(stderr," kht.mod");
    fprintf(stderr," klt.mod");
    fprintf(stderr," leak.mod");
    fprintf(stderr," mujpow.mod");
    fprintf(stderr," na.mod");
    fprintf(stderr, "\n");
  }
  _hcno_reg();
  _ih_reg();
  _ka_reg();
  _kht_reg();
  _klt_reg();
  _leak_reg();
  _mujpow_reg();
  _na_reg();
}
