RM := rm -rf
OUTDIR=./lib/
TARGET=$(OUTDIR)/libCountlyCpp.a
OBJDIR=./obj/
SRCDIR=.
TESTMAIN=CountlyTest

CPP_SRCS += \
$(SRCDIR)/Countly.cpp \
$(SRCDIR)/CountlyConnectionQueue.cpp  \
$(OBJDIR)/CountlyEventQueue.cpp \
$(SRCDIR)/sqlite3.c


OBJS += \
$(OBJDIR)/Countly.o \
$(OBJDIR)/CountlyConnectionQueue.o  \
$(OBJDIR)/CountlyEventQueue.o \
$(OBJDIR)/sqlite3.o 


	
all:  test

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ $(CFLAGS) $(INCLUDEDIR) -x objective-c++ -c  -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"  -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo 'Building C file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc $(CFLAGS) $(INCLUDEDIR) -c  -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"  -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

$(TARGET): $(OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC Archiver'
	ar -r  $(TARGET) $(OBJS)   $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '    
	
test: $(TARGET)
	g++ TestCountly.cpp -o $(TESTMAIN) -L$(OUTDIR) -lCountlyCpp 

	
clean:
	-$(RM) $(OBJS) $(TARGET) $(TESTMAIN) 
	-@echo ' '
	
	
	
