%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_contract_address
from starkware.cairo.common.math_cmp import is_le
from starkware.cairo.common.alloc import alloc

from contracts.utils.IExercices import (
    IEx01,
    IEx02,
    IEx03,
    IEx04,
    IEx05,
    IEx06,
    IEx07,
    IEx08,
    IEx09,
    IEx10,
    IEx10b,
    IEx11,
    IEx12,
    IEx13,
    IEx14,
)

@storage_var
func exerciseAddressFromId(id : felt) -> (address : felt):
end

@storage_var
func expectedValueEx12() -> (value : felt):
end

@storage_var
func expectedValueEx13() -> (value : felt):
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    exerciseAddressFromId.write(1, 0x29e2801df18d7333da856467c79aa3eb305724db57f386e3456f85d66cbd58b)
    exerciseAddressFromId.write(2, 0x18ef3fa8b5938a0059fa35ee6a04e314281a3e64724fe094c80e3720931f83f)
    exerciseAddressFromId.write(3, 0x79275e734d50d7122ef37bb939220a44d0b1ad5d8e92be9cdb043d85ec85e24)
    exerciseAddressFromId.write(4, 0x2cca27cae57e70721d0869327cee5cb58098af4c74c7d046ce69485cd061df1)
    exerciseAddressFromId.write(5, 0x399a3fdd57cad7ed2193bdbb00d84553cd449abbdfb62ccd4119eae96f827ad)
    exerciseAddressFromId.write(6, 0x718ece7af4fb1d9c82f78b7a356910d8c2a8d47d4ac357db27e2c34c2424582)
    exerciseAddressFromId.write(7, 0x3a1ad1cde69c9e7b87d70d2ea910522640063ccfb4875c3e33665f6f41d354a)
    exerciseAddressFromId.write(8, 0x15fa754c386aed6f0472674559b75358cde49db8b2aba8da31697c62001146c)
    exerciseAddressFromId.write(9, 0x2b9fcc1cfcb1ddf4663c8e7ac48fc87f84c91a8c2b99414c646900bf7ef5549)
    exerciseAddressFromId.write(10, 0x8415762f4b0b0f44e42ac1d103ac93c3ea94450a15bb65b99bbcc816a9388)
    exerciseAddressFromId.write(11, 0xab5577b9be8948d89dbdba63370a3de92e72a23c4cacaea38b3a74eec3a872)
    exerciseAddressFromId.write(12, 0x24d15e02ddaa19d7ecd77204d35ed9bfff00a0cabc62eb3da5ba7680e44baf9)
    exerciseAddressFromId.write(13, 0x2bae9190076c4252289b8a8671277cef57318192cff20c736808b0c71095895)
    exerciseAddressFromId.write(14, 0xed7ddffe1370fbbc1974ab8122d1d9bd7e3da8d829ead9177ea4249b4caef1)
    return ()
end

func _resolveEx01{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_01) = exerciseAddressFromId.read(1)
    IEx01.claim_points(contract_address=_ex_01)

    return (1)
end

func _resolveEx02{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_02) = exerciseAddressFromId.read(2)
    let (secret_value) = IEx02.my_secret_value(contract_address=_ex_02)
    IEx02.claim_points(contract_address=_ex_02, my_value=secret_value)

    return (1)
end

func _resolveEx03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    alloc_locals
    let (local _ex_03) = exerciseAddressFromId.read(3)
    let (address_this) = get_contract_address()
    let (counter) = IEx03.user_counters(contract_address=_ex_03, account=address_this)
    if counter == 7:
        IEx03.claim_points(contract_address=_ex_03)
        return (1)
    end
    let (is_counter_less) = is_le(counter, 7)
    if is_counter_less == 1:
        IEx03.increment_counter(contract_address=_ex_03)
    else:
        IEx03.decrement_counter(contract_address=_ex_03)
    end

    return _resolveEx03()
end

func _resolveEx04{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_04) = exerciseAddressFromId.read(4)
    IEx04.assign_user_slot(contract_address=_ex_04)
    let (address_this) = get_contract_address()
    let (slot) = IEx04.user_slots(contract_address=_ex_04, account=address_this)
    let (value) = IEx04.values_mapped(contract_address=_ex_04, slot=slot)
    IEx04.claim_points(contract_address=_ex_04, expected_value=value - 32)

    return (1)
end

func _resolveEx05{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_05) = exerciseAddressFromId.read(5)
    IEx05.assign_user_slot(contract_address=_ex_05)
    IEx05.copy_secret_value_to_readable_mapping(contract_address=_ex_05)
    let (address_this) = get_contract_address()
    let (value) = IEx05.user_values(contract_address=_ex_05, account=address_this)
    IEx05.claim_points(contract_address=_ex_05, expected_value=value)

    return (1)
end

func _resolveEx06{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_06) = exerciseAddressFromId.read(6)
    IEx06.assign_user_slot(contract_address=_ex_06)
    IEx06.external_handler_for_internal_function(contract_address=_ex_06, a_value=0)
    let (address_this) = get_contract_address()
    let (value) = IEx06.user_values(contract_address=_ex_06, account=address_this)
    IEx06.claim_points(contract_address=_ex_06, expected_value=value)

    return (1)
end

func _resolveEx07{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_07) = exerciseAddressFromId.read(7)
    IEx07.claim_points(contract_address=_ex_07, value_a=40, value_b=0)

    return (1)
end

func _resolveEx08{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    alloc_locals
    let (_ex_08) = exerciseAddressFromId.read(8)
    let (address_this) = get_contract_address()
    let (local array) = alloc()
    assert [array] = 10
    assert [array + 1] = 9
    assert [array + 2] = 8
    assert [array + 3] = 7
    assert [array + 4] = 6
    assert [array + 5] = 5
    assert [array + 6] = 4
    assert [array + 7] = 3
    assert [array + 8] = 2
    assert [array + 9] = 1
    assert [array + 10] = 0
    IEx08.set_user_values(contract_address=_ex_08, account=address_this, array_len=11, array=array)
    IEx08.claim_points(contract_address=_ex_08)

    return (1)
end

func _resolveEx09{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    alloc_locals
    let (_ex_09) = exerciseAddressFromId.read(9)
    let (local array) = alloc()
    assert [array] = 80
    assert [array + 1] = 40
    assert [array + 2] = 20
    assert [array + 3] = 10
    IEx09.claim_points(contract_address=_ex_09, array_len=4, array=array)

    return (1)
end

func _resolveEx10{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_10) = exerciseAddressFromId.read(10)
    let (_ex_10_b) = IEx10.ex10b_address(contract_address=_ex_10)
    let (value) = IEx10b.secret_value(contract_address=_ex_10_b)
    IEx10.claim_points(
        contract_address=_ex_10, secret_value_i_guess=value, next_secret_value_i_chose=value + 1
    )

    return (1)
end

func _resolveEx11{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_11) = exerciseAddressFromId.read(11)
    let (fake_value) = IEx11.secret_value(contract_address=_ex_11)
    let value = fake_value - 42069
    IEx11.claim_points(
        contract_address=_ex_11, secret_value_i_guess=value, next_secret_value_i_chose=value + 1
    )

    return (1)
end

func _resolveEx12{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_12) = exerciseAddressFromId.read(12)
    let (expected_value) = expectedValueEx12.read()
    IEx12.claim_points(contract_address=_ex_12, expected_value=expected_value)
    return (1)
end

func _resolveEx13{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_13) = exerciseAddressFromId.read(13)
    let (expected_value) = expectedValueEx13.read()
    IEx13.claim_points(contract_address=_ex_13, expected_value=expected_value)
    return (1)
end

@external
func initEx12Slot{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_12) = exerciseAddressFromId.read(12)
    let (address_this) = get_contract_address()
    IEx12.assign_user_slot(contract_address=_ex_12)
    return (1)
end

@external
func initEx13Slot{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    success : felt
):
    let (_ex_13) = exerciseAddressFromId.read(13)
    let (address_this) = get_contract_address()
    IEx13.assign_user_slot(contract_address=_ex_13)
    return (1)
end

@external
func executeEx14ClaimPoints{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    expected_value_Ex12 : felt, expected_value_Ex13 : felt
) -> (success : felt):
    let (_ex_14) = exerciseAddressFromId.read(14)
    expectedValueEx12.write(expected_value_Ex12)
    expectedValueEx13.write(expected_value_Ex13)
    IEx14.claim_points(contract_address=_ex_14)

    return (1)
end

@external
func validate_various_exercises{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    ):
    _resolveEx01()
    _resolveEx02()
    _resolveEx03()
    _resolveEx04()
    _resolveEx05()
    _resolveEx06()
    _resolveEx07()
    _resolveEx08()
    _resolveEx09()
    _resolveEx10()
    _resolveEx11()
    _resolveEx12()
    _resolveEx13()

    return ()
end
