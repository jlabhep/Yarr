#ifndef EMUCOM_H
#define EMUCOM_H

#include <cstdint>

class EmuCom {
    public:
        virtual bool isEmpty() = 0;
        virtual uint32_t read32() = 0;
        virtual void write32(uint32_t) = 0;
    protected:
        EmuCom();
        ~EmuCom();
};

#endif
