#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _hcno_reg(void);
extern void _khtoz_reg(void);
extern void _kltoz_reg(void);
extern void _leak_reg(void);
extern void _nas_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," hcno.mod");
    fprintf(stderr," khtoz.mod");
    fprintf(stderr," kltoz.mod");
    fprintf(stderr," leak.mod");
    fprintf(stderr," nas.mod");
    fprintf(stderr, "\n");
  }
  _hcno_reg();
  _khtoz_reg();
  _kltoz_reg();
  _leak_reg();
  _nas_reg();
}
