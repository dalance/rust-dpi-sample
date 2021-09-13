use std::ffi::CStr;
use std::os::raw::c_char;
use std::ptr::NonNull;
use sv4state::{svLogicVecVal, Sv4State};

#[no_mangle]
pub extern "C" fn add_i8(x: i8, y: i8) -> i8 {
    x + y
}

#[no_mangle]
pub extern "C" fn add_i16(x: i16, y: i16) -> i16 {
    x + y
}

#[no_mangle]
pub extern "C" fn add_i32(x: i32, y: i32) -> i32 {
    x + y
}

#[no_mangle]
pub extern "C" fn add_i64(x: i64, y: i64) -> i64 {
    x + y
}

#[no_mangle]
pub extern "C" fn add_by_output(x: i64, y: i64, z: &mut i64) {
    *z = x + y
}

#[no_mangle]
pub extern "C" fn xor_bit(x: &[u8; 64], y: &[u8; 64], z: &mut [u8; 64]) {
    for i in 0..64 {
        z[i] = x[i] ^ y[i];
    }
}

#[no_mangle]
pub extern "C" fn show_logic(x: &[svLogicVecVal; 4]) {
    let sv_u64 = Sv4State::<u64>::from_dpi(x);
    println!("{:x}", sv_u64[0]);
}

#[no_mangle]
pub extern "C" fn unpacked_array(x: &[i32; 10]) {
    print!("unpacked_array: ");
    for i in 0..10 {
        print!("{}", x[i]);
    }
    println!("");
}

#[no_mangle]
pub extern "C" fn print(a: *const c_char) {
    let a = unsafe { CStr::from_ptr(a) };
    dbg!(a);
}

#[no_mangle]
pub extern "C" fn create() -> NonNull<Object> {
    let obj = Box::new(Object {
        x: 10000,
        y: String::from("Hello"),
    });
    let obj = Box::<Object>::into_raw(obj);
    NonNull::new(obj).unwrap()
}

#[no_mangle]
pub extern "C" fn destroy(ptr: NonNull<Object>) {
    let obj = unsafe { Box::<Object>::from_raw(ptr.as_ptr()) };
    println!("{:?} is destroied", obj);
}

#[derive(Debug)]
pub struct Object {
    x: usize,
    y: String,
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
